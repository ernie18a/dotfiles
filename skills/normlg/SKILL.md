---
name: normlg
description: Create one normlgNN.md LG entry from raw requests, feature lists, messy specs, or broad plans by applying an internal normalization pass first. Use when direct lg generation would be too raw because the source lacks executable scope, evidence, verification, or stop conditions.
---

# NormLG

## Role

Create one LG entry from raw source material in a single pass.

Use normalization as an internal compiler step: shape the source into goal, current slice, scope, evidence, verification, and stop conditions, then compile those decisions into the LG entry.

## Workflow

1. Read the source material.
   Use the user's target files or request text as input. Treat examples, chat phrasing, and feature inventories as evidence of intent, not as text to preserve.

2. Normalize the source.
   Derive the execution contract:
   - terminal goal
   - current executable slice
   - allowed scope
   - forbidden scope
   - inputs
   - evidence
   - verification
   - stop conditions

3. Write `normlgNN.md`.
   Use the next available number. The entry must identify:
   - terminal and current goal
   - execution scope
   - inputs and task index
   - next smallest action
   - boundaries
   - evidence required
   - verification
   - completion criteria
   - stop conditions
   - handoff

4. Keep the pass tight.
   Preserve broad intent as terminal scope or future constraints. Put only the next verifiable action into current scope. State missing authority, target files, evidence, or verification as blockers.

## Output

Create or update the LG entry:
- `normlgNN.md`

Report the created files and any blocker that prevents a trustworthy LG entry.
