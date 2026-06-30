---
name: norm
description: Normalize raw requests, feature lists, messy specs, or broad plans into a compact execution-ready spec before using os, lg, dual, or direct implementation. Use when source material says what is wanted but lacks scope, task size, evidence, stop conditions, or a clear downstream handoff choice.
---

# Norm

## Role

Convert raw intent into the smallest useful execution spec. Treat this skill as a preprocessor, not as the executor and not as the final handoff format.

Use it when a request, `enable*.md`, feature list, draft plan, chat summary, or broad requirement is too raw for `os`, `lg`, `dual`, or direct code work.

## Boundary

`norm` owns input shaping:
- identify the real goal and current executable slice
- remove noisy, duplicated, decorative, or over-broad requirements
- preserve only constraints that affect execution, safety, verification, recovery, or routing
- choose whether the shaped work should go to `os`, `lg`, `dual`, or direct implementation
- state what evidence would make completion auditable

`norm` does not:
- execute the task
- claim completion
- create runtime state
- force a phased plan when one small action is enough
- preserve every feature-list item as immediate scope
- hide unresolved scope, authority, or verification gaps

## Workflow

1. Check the premise.
   Decide whether the source is already executable. If it has a clear small action, allowed scope, evidence, and stop condition, do not add another planning layer.

2. Classify task size.
   - Direct implementation: small local change with obvious files and verification.
   - `os`: one-shot handoff for small tools or tightly bounded work.
   - `lg`: resumable runtime entry where next action, checkpoint audit, stale evidence, or false completion matter.
   - `dual`: planner-worker contract for broad work, high-risk boundaries, or tasks likely to be falsely declared done.

3. Normalize the source.
   Replace feature inventory with execution boundaries:
   - terminal goal
   - current slice
   - allowed scope
   - forbidden scope
   - required inputs
   - evidence required
   - verification
   - stop conditions
   - recommended downstream handoff

4. Preserve terminal intent without inflating the next action.
   Keep broad end-state requirements as terminal constraints or future scope. Put only the next smallest verifiable action into current scope.

5. Expose blockers.
   If the source lacks required authority, target files, success evidence, safe verification, or task size control, state the missing condition instead of inventing it.

## Output

Return a compact normalized spec, not a full `os`, `lg`, or `dual` artifact unless the user asks for that next conversion.

Use this shape by default:

```md
## Normalized Execution Spec

Goal:
- terminal:
- current:

Scope:
- allowed:
- forbidden:

Inputs:
- ...

Evidence:
- ...

Verification:
- ...

Stop:
- ...

Route:
- recommended:
- reason:
```

Keep examples out unless they clarify a routing boundary. Prefer short decision rules over background explanation.
