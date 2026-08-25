---
name: norm
description: Normalize raw requests, feature lists, messy specs, or broad plans into a compact intermediate spec. Use when source material says what is wanted but lacks executable scope, evidence, verification, or stop conditions.
---

# Norm

## Role

Convert raw intent into the smallest useful normalized spec.

Use it when a request, `enable*.md`, feature list, draft plan, chat summary, or broad requirement is too raw, broad, duplicated, or underspecified to guide the next executable step.

The output is a standalone intermediate spec document named incrementally as `normNN.md`, for example `norm01.md`, `norm02.md`.

## Boundary

`norm` owns input shaping:

- identify the real goal and current executable slice
- remove noisy, duplicated, decorative, or over-broad requirements
- preserve only constraints that affect execution, safety, verification, or recovery
- state what evidence would make completion auditable

Keep the output limited to input shaping: goal, current slice, scope, evidence, verification, and stop conditions.

## Workflow

1. Check the premise.
   If the source already has a clear small action, scope, evidence, and stop condition, compile it into `normNN.md`.

2. Normalize the source.
   Replace feature inventory with execution boundaries:

   - terminal goal
   - current slice
   - allowed scope
   - forbidden scope
   - required inputs
   - evidence required
   - verification
   - stop conditions

3. Preserve terminal intent without inflating the next action.
   Keep broad end-state requirements as terminal constraints or future scope. Put only the next smallest verifiable action into current scope.

4. Expose blockers.
   If the source lacks required authority, target files, success evidence, safe verification, or task size control, state the missing condition instead of inventing it.

## Output

Write a compact normalized spec document as `normNN.md`.

Use this shape by default:

```md
# normNN

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
```

Keep examples out unless they clarify a decision boundary. Prefer short decision rules over background explanation.
