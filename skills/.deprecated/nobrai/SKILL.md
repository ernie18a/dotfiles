---
name: nobrai
description: Use when the user asks for a direct operation, fixed transformation, simple file edit, batch overwrite, literal command, or one-step implementation and the task should not be expanded with unrequested discovery, filtering, abstraction, fallback logic, preservation logic, configuration, or framework design.
---

# Nobrai

## Role

Execute the requested operation at the same level of mechanism the user specified.

## Rule

Do not add machinery that is not required to complete the explicit request.

Machinery includes:
- discovery before a fixed target is already specified
- filtering when the user requested all targets
- preserving existing structure when the user requested overwrite
- configuration for a one-off command
- abstraction for a single concrete case
- fallback paths not required by the stated task
- validation beyond syntax, existence, permissions, and direct failure signals

## Procedure

1. Extract the explicit operation, target, and output.
2. Execute only the operation needed to produce that output.
3. Stop when the requested output exists or the direct operation fails.

## Boundary

If completing the request requires choosing between destructive targets, unknown paths, missing input, or irreversible external effects, stop and report the missing condition.

If the user requests a safeguard, generalization, scan, merge, or preservation rule, implement that rule directly.

## Output

Report:
1. what was done
2. what was not added
3. any missing condition that blocked direct execution
