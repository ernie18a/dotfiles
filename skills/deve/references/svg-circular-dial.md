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

JS — derive all segments from a single boundary array so arcs, dividers, and labels share one source of truth:

```js
const RING_COLOR = "#3f4752";  // neutral gray for all segments
const segBounds = [0, 5, 10, 15, 20, 24];

function renderSegments() {
  for (let i = 0; i < segBounds.length - 1; i++) {
    const start = segBounds[i];
    const end = segBounds[i + 1];
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

The same `segBounds` array also drives sector boundary lines — see below.

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

For keyboard navigation with integer-hour snapping, see the [Keyboard Navigation section](#keyboard-navigation-hour-snapped-mode) below.

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

## Inner Ring Labels (Rotating Segment Labels)

Text labels on the inner ring must rotate with it, so place `<text>` elements INSIDE `<g id="innerRing">`. Each label is positioned at the segment's midpoint hour. Use `pointer-events: none` to let pointer events pass through to the drag handler on the dial container.

### Data Model

Define segment boundaries once, then derive both the arcs and the label midpoints from it:

```js
const segBounds = [0, 5, 10, 15, 20, 24]; // divisions aligned to hour ticks

// Gray ring segments are derived by iterating consecutive pairs
for (let i = 0; i < segBounds.length - 1; i++) {
  const start = segBounds[i];
  const end = segBounds[i + 1];
  // render arcPath(RADIUS, start, end) ...
}

// Sector boundary lines at each division point
for (const hour of segBounds) {
  // render radial line from RADIUS-16 to RADIUS+16 ...
}
```

### Label Data + Positioning

Labels are declared as an array with their midpoint hour and text. The midpoint of a segment `[S, E]` is `(S + E) / 2`. Position at `polarPoint(RADIUS, midpointHour)` — the center of the ring stroke:

```js
const labels = [
  { hour: 0.5, text: "1", cls: "highlight" },  // accent zone 0-1h
  { hour: 2.5, text: "5" },                     // gray segment 0-5h
  { hour: 7.5, text: "5" },                     // gray segment 5-10h
  { hour: 12.5, text: "5" },                    // gray segment 10-15h
  { hour: 17.5, text: "5" },                    // gray segment 15-20h
  { hour: 22, text: "4" },                      // gray segment 20-24h (4h)
];

for (const { hour, text, cls } of labels) {
  const pos = polarPoint(INNER_RING_RADIUS, hour);
  const el = createSvgElement("text", {
    class: cls ? `inner-ring-label ${cls}` : "inner-ring-label",
    x: pos.x,
    y: pos.y,
    "pointer-events": "none",       // must not block drag
  });
  el.textContent = text;
  innerRing.append(el);
}
```

**Why `RADIUS` (center of stroke)**: the ring has `stroke-width: 26`, so it spans from `RADIUS - 13` to `RADIUS + 13`. Placing text at `RADIUS` (e.g., 105) centers it on the visible ring. Verify: the center semicircle has `r = RADIUS - 13` (e.g., 92), so label text at `RADIUS` is outside the center fill.

### CSS

```css
.inner-ring-label {
  fill: #e8e0d0;                   /* same light color as outer tick labels */
  font: 700 11px/1 ui-monospace, "SFMono-Regular", Consolas, monospace;
  text-anchor: middle;
  dominant-baseline: central;       /* vertical centering for single digit */
  pointer-events: none;             /* drag-through compatibility */
  user-select: none;                /* prevent text selection during drag */
}

.inner-ring-label.highlight {
  fill: #b8dfc8;                   /* match the accent marker color */
}
```

### Critical: Label vs Segment Geometry

When an accent marker (e.g., a green highlight at 0-1h) overlaps a gray segment (e.g., 0-5h), the labels for both live at different midpoints and are well-separated:

| Label | Midpoint | Position on dial | Visual zone |
|-------|----------|-------------------|-------------|
| "1" (highlight) | hour 0.5 | r=105, top-right | green highlight 0-1h |
| "5" | hour 2.5 | r=105, right | gray segment 0-5h |

The gap between hour 0.5 and hour 2.5 is `2 × 15° = 30°`, with a sector boundary at hour 1 (the boundary between highlight and adjacent gray) — so labels never overlap.

### Radial Text Orientation (Bottom Faces Center)

By default SVG text renders horizontally. On a rotating ring, each label should point radially so the bottom of each digit faces the center and the top faces outward.

Apply a `transform="rotate(angle x y)"` centered on the text's own position:

```js
const angle = (hour / FULL_DAY) * 360;
const el = createSvgElement("text", {
  class: "inner-ring-label",
  x: pos.x, y: pos.y,
  transform: `rotate(${angle} ${pos.x} ${pos.y})`,
  "pointer-events": "none",
});
```

**Why this angle works**: a digit at hour 0 (top) needs 0° (bottom already faces center). A digit at hour 6 (right) needs 90° clockwise so bottom faces left (center). The formula `hour/24*360` produces these for every position.

**Composition with group rotation**: the text's own `rotate()` applies first (in SVG transform order), then the innerRing group `rotate()` applies. Labels keep their radial orientation regardless of ring position. Labels on the bottom half appear inverted relative to the screen — correct radial behavior.

| Hour | Angle | Orientation |
|------|-------|-------------|
| 0.5  | 7.5°  | top-right, bottom toward center |
| 2.5  | 37.5° | right side, bottom toward center |
| 7.5  | 112.5°| lower-right, bottom toward center |
| 12.5 | 187.5°| bottom (inverted), bottom toward center |
| 17.5 | 262.5°| lower-left, bottom toward center |
| 22   | 330°  | upper-left, bottom toward center |

### Integer-Hour Snapping (Sticky to Ticks)

For a tick-aligned dial, snap rotation to the nearest integer hour on every interaction:

```js
function setHour(hour) {
  // Modulo first to get into [0, 24), round to integer, modulo again
  // to catch Math.round(23.96) -> 24 -> 0
  selectedHour = Math.round(((hour % FULL_DAY) + FULL_DAY) % FULL_DAY) % FULL_DAY;
  const angle = (selectedHour / FULL_DAY) * 360;
  innerRing.setAttribute("transform", `rotate(${angle} ${CENTER} ${CENTER})`);
  dial.setAttribute("aria-valuenow", String(selectedHour));
}
```

**Edge case**: when the pointer is near midnight (~23.96), `Math.round` produces 24. The extra `% FULL_DAY` wraps it back to 0. Without it, `selectedHour` would be 24, breaking future modulo math.

**Old state compatibility**: if state stores a decimal (e.g. 23.38), `loadState()` calls `setHour(23.38)` which rounds to 23 on first load. The next save writes an integer.

### aria-valuenow

When snapping to integer hours, set as an integer string:

```js
dial.setAttribute("aria-valuenow", String(selectedHour));
```

## Keyboard Navigation (Hour-Snapped Mode)

When the dial snaps to integer hours, all keyboard steps must be whole-hour:

```js
dial.addEventListener("keydown", (event) => {
  const keySteps = {
    ArrowUp: 1,    ArrowRight: 1,
    ArrowDown: -1, ArrowLeft: -1,
    PageUp: 1,     PageDown: -1,
    Home: -selectedHour,                 // -> hour 0
    End: FULL_DAY - selectedHour - 1,    // -> hour 23
  };
  if (!(event.key in keySteps)) return;
  event.preventDefault();
  setHour(selectedHour + keySteps[event.key]);
});
```

**End key pitfall**: `FULL_DAY - selectedHour` produces 24 when `selectedHour=0`, which modulo-wraps to 0. To reach hour 23 (the last hour), use `FULL_DAY - selectedHour - 1`.

### Rotation Behaviour

Because the `<text>` elements are children of `<g id="innerRing">`, they rotate with the ring when `setHour()` applies a `transform="rotate(...)"`. Single-digit labels remain perfectly readable at any rotation angle since there's no multi-character baseline to break.

## Verification

After changing circular geometry, verify every boundary lands on the correct position:
- **By calculation**: log `startHour × 15` and `endHour × 15` for each segment — every result must be a multiple of 15.
- **By inspection**: open the page and check that each segment boundary aligns with an outer hour tick.
- **By loading saved state**: rotate, reload, confirm rotation persists.
