---
name: sss
description: Manual invocation only
---

# SSS

Preserve the outcome required by the current task.

1. Determine the required outcome from the target and request. If it cannot be determined, stop without reducing.
2. Decompose the target and request into intent, invariant, constraint, and action units. Discard their original wording and classify roles, stances, rationale, and other context that does not affect the required outcome as removable.
3. Resolve supported overlap and conflict, leave unsupported intent unresolved, and reconstruct the target from the resulting units.
4. For each removable part:
   1. Temporarily remove it and reconstruct the target.
   2. Check whether the required outcome still holds.
   3. Permanently remove it only when the outcome demonstrably still holds.
5. Repeat until removing any remaining part would break the outcome or make it undecidable.

Do not change the required outcome, expand the task, or treat this analysis as authorization to act.
