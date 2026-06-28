# SVG Circular Dial / Ring / Clock UI Patterns

Rendering interactive circular dials with stdlib SVG — no framework, no canvas, no D3.

## Coordinate Model

### Polar to Cartesian

Map a logical unit (hour, sector, percentage) to a point on the SVG circle:

```js
const CENTER = 180;   // viewBox center
const FULL_DAY = 24;  // one full cycle in logical units
const RADIUS = 105;

function polarPoint(radius, hour) {
  // hour 0 → top (12 o'clock), clockwise
  const angle = (hour / FULL_DAY) * 360 - 90;
  const radians = (angle * Math.PI) / 180;
  return {
    x: CENTER + radius * Math.cos(radians),
    y: CENTER + radius * Math.sin(radians),
  };
}
```

**Key**: subtract 90° from the angle so `hour=0` is at the top. Without this, `hour=0` would be at 3 o'clock (the SVG 0° default).

### Arc Path Between Two Logical Units

```js
function arcPath(radius, startHour, endHour) {
  const start = polarPoint(radius, startHour);
  const end = polarPoint(radius, endHour);
  const largeArc = endHour - startHour > (FULL_DAY / 2) ? 1 : 0;
  return `M ${start.x} ${start.y} A ${radius} ${radius} 0 ${largeArc} 1 ${end.x} ${end.y}`;
}
```

The sweep flag is always `1` (clockwise). The large-arc flag is `1` when the arc exceeds half the circle, `0` otherwise.

### Angles Cheat Sheet (for FULL_DAY=24)

| Unit | Degrees |
|------|---------|
| 1 hour | 15° |
| 4 hours | 60° |
| 5 hours | 75° |
| 6 hours | 90° |
| 8 hours | 120° |
| 12 hours | 180° |
| 24 hours | 360° |

## Ring / Segment Rendering SVG Structure

```svg
<svg viewBox="0 0 360 360">
  <g class="ticks"></g>        <!-- outer scale tick marks + labels -->
  <g class="inner-ring" id="innerRing"></g>  <!-- draggable inner ring -->
  <path class="center-..." />  <!-- center fill on top of ring -->
</svg>
```

### Segments (animated arcs with stroke)

```css
.inner-ring-seg {
  fill: none;
  stroke-width: 26;          /* controls ring thickness */
  stroke-linecap: butt;
  pointer-events: none;      /* let pointer events pass through to the dial container */
}
```

JS:
```js
// One neutral gray for all segments (no multicolor palette)
const RING_COLOR = "#3f4752";

function renderSegments() {
  const blocks = [0, 5, 10, 15];
  for (const start of blocks) {
    const end = start + 5;
    innerRing.append(
      createSvgElement("path", {
        class: "inner-ring-seg",
        d: arcPath(INNER_RING_RADIUS, start, end),
        stroke: RING_COLOR,
      }),
    );
  }
}
```

### Rotating the Inner Ring (Drag Interaction)

Put the ring group inside `g#innerRing`, apply a rotation transform:

```js
function setHour(hour) {
  const angle = (hour / FULL_DAY) * 360;
  innerRing.setAttribute("transform", `rotate(${angle} ${CENTER} ${CENTER})`);
}
```

Pointer events on the dial container, not on the SVG children:

```js
dial.addEventListener("pointerdown", startDrag);
dial.addEventListener("pointermove", moveDrag);
dial.addEventListener("pointerup", endDrag);

function hourFromPointer(event) {
  const rect = dial.getBoundingClientRect();
  const x = event.clientX - rect.left - rect.width / 2;
  const y = event.clientY - rect.top - rect.height / 2;
  const degrees = (Math.atan2(y, x) * 180) / Math.PI + 90;
  return (((degrees + 360) % 360) / 360) * FULL_DAY;
}
```

CSS safeguards:
```css
.dial {
  touch-action: none;
  user-select: none;
  -webkit-user-select: none;
}
```

Keyboard navigation:
```js
dial.addEventListener("keydown", (event) => {
  const keySteps = {
    ArrowUp: 0.25, ArrowRight: 0.25,
    ArrowDown: -0.25, ArrowLeft: -0.25,
    PageUp: 1, PageDown: -1,
    Home: -selectedHour,
    End: FULL_DAY - selectedHour,
  };
  if (!(event.key in keySteps)) return;
  event.preventDefault();
  setHour(selectedHour + keySteps[event.key]);
});
```

## Exact-Hour vs Equal-Sector Geometry

Two competing constraints in circular-dial design:

| Approach | Equation | Arc width | Tick alignment | Use case |
|----------|----------|-----------|----------------|----------|
| Equal sectors | `circle / N` | `360° / N` | Off-tick | Visual rhythm, uniform color blocks |
| Hour-aligned | `N hours × 15°` | `N × 15°` | Exact | Clockface, time-based UIs |

**When the inner ring must align with outer hour ticks**, always use hour-aligned geometry:

```js
// ❌ Equal visual sectors (drifts from tick marks)
const SECTOR = 24 / 5; // 4.8h = 72° — does NOT align with hour 5, 10, 15...

// ✓ Hour-aligned (every boundary lands on an hour tick)
const blocks = [0, 5, 10, 15]; // 4 × 5h = 75° each
// Last block: 20-24 = 4h = 60°
// Sector boundaries at 0, 5, 10, 15, 20, 24
```

## Sector Boundaries (Divider Lines)

Thick radial lines at each division boundary identify the 5 timeframes when segments are monochrome:

```js
for (let hour = 0; hour <= 24; hour += 5) {
  const outer = polarPoint(RADIUS + 16, hour);
  const inner = polarPoint(RADIUS - 16, hour);
  innerRing.append(
    createSvgElement("line", {
      class: "sector-boundary",
      x1: outer.x, y1: outer.y, x2: inner.x, y2: inner.y,
    }),
  );
}
```

```css
.sector-boundary {
  stroke: rgba(232, 224, 208, .45);
  stroke-width: 2.8;
  pointer-events: none;
}
```

## Overlay / Marker Elements

When a visual accent must sit on top of a segment (e.g., a mismatch marker), render it AFTER the main segments so it's later in the DOM and paints on top:

```js
// Main segments first
renderSegments();

// Then overlay marker
innerRing.append(
  createSvgElement("path", {
    class: "mismatch-marker",
    d: arcPath(RADIUS, 0, 1),   // exactly 15° at the top
    stroke: "#5a9f8a",
  }),
);
```

Overlay marker CSS — slightly thicker stroke + optional glow:

```css
.mismatch-marker {
  fill: none;
  stroke-width: 30;
  stroke-linecap: butt;
  pointer-events: none;
  filter: drop-shadow(0 0 4px rgba(90, 159, 138, .35));
}
```

## Outer Tick Scale (Fixed)

Outer ring ticks and hour labels must NOT rotate with the inner ring. Keep them in a separate `<g class="ticks">` that sits outside `g#innerRing`:

```svg
<g class="ticks"></g>        <!-- fixed — never transformed -->
<g class="inner-ring" id="innerRing"></g>  <!-- gets rotate() transform -->
```

Tick rendering (radial lines + numeric labels):

```js
function renderTicks() {
  for (let hour = 0; hour < FULL_DAY; hour += 1) {
    const isMajor = hour % 6 === 0;
    const outer = polarPoint(159, hour);
    const inner = polarPoint(isMajor ? 144 : 151, hour);
    ticks.append(createSvgElement("line", {
      class: `tick-line${isMajor ? " major" : ""}`,
      x1: outer.x, y1: outer.y, x2: inner.x, y2: inner.y,
    }));

    const label = polarPoint(170, hour);
    const text = createSvgElement("text", {
      class: "tick-label", x: label.x, y: label.y,
    });
    text.textContent = hour === 0 ? "0/24" : String(hour);
    ticks.append(text);
  }
}
```

```css
.tick-label {
  fill: #e8e0d0;
  font: 700 11px/1 ui-monospace, "SFMono-Regular", Consolas, monospace;
  text-anchor: middle;
  dominant-baseline: middle;
}
```

## Center Split-Circle (Two Semicircles)

Replace a single `<circle>` fill with two SVG `<path>` elements for a horizontal split:

```svg
<!-- Top semicircle: dark gray -->
<path class="center-top" d="M 88 180 A 92 92 0 0 0 272 180 Z" />
<!-- Bottom semicircle: light gray -->
<path class="center-bottom" d="M 272 180 A 92 92 0 0 0 88 180 Z" />
```

**Arc direction**: sweep-flag=0 (counter-clockwise) from `M 88 180` to `272 180` goes through the top. From `M 272 180` back to `88 180` with sweep-flag=0 goes through the bottom. The `Z` closes each shape along the horizontal diameter.

```css
.center-top { fill: #1a1f26; pointer-events: none; }
.center-bottom { fill: #a0a8b0; pointer-events: none; }
```

The center radius must match the inner edge of the ring segments. With `INNER_RING_RADIUS=105` and `stroke-width=26`, the inner edge is at `105 - 13 = 92`, so `r=92`.

## SVG Element Factory

Use a helper to avoid verbose `createElementNS` calls:

```js
function createSvgElement(type, attrs) {
  const node = document.createElementNS("http://www.w3.org/2000/svg", type);
  Object.entries(attrs).forEach(([key, value]) => node.setAttribute(key, value));
  return node;
}
```

## SVG Shadow Filter

A drop-shadow on the dial SVG gives depth without a rectangular box effect:

```svg
<defs>
  <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
    <feDropShadow dx="0" dy="8" stdDeviation="10" flood-color="#000" flood-opacity=".40" />
  </filter>
</defs>
```

```css
.dial-svg {
  filter: url("#shadow");
}
```

## Verification

After changing circular geometry, verify every boundary lands on the correct position:
- **By calculation**: log `startHour × 15` and `endHour × 15` for each segment — every result must be a multiple of 15.
- **By inspection**: open the page and check that each segment boundary aligns with an outer hour tick.
- **By loading saved state**: rotate, reload, confirm rotation persists.
