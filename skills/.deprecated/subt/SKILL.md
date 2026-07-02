---
name: subt
description: Manual invocation only
---

# Subt

## Role

Improve editable artifacts by preserving intent, removing patch accumulation, and adding material only when necessary.

## Core Principle

Treat user wording as evidence of intent, not default artifact text. Translate it into the behavior the artifact must produce unless the wording itself is the intended final text.

Evaluate every constraint, example, and section by the outcome it protects. Keep only material that establishes user intent, correctness, safety, or a clear contract. Express general behavior as a decision rule; retain examples only when they clarify a decision boundary that the rule alone cannot.

Use behavior and decision criteria as the default form. Use negative phrasing when it most clearly defines a non-negotiable safety, correctness, or contract boundary.

## Premise Check

Before editing, identify:
- what the artifact is trying to do
- what behavior the user wants changed
- which existing text already causes or blocks that behavior
- whether the requested change means deletion, replacement, reordering, or addition

When the user's wording and the artifact's structure differ, use the structure that produces the intended behavior.

## Edit Order

Apply edits in this order:

1. Reorder by purpose
   - Move related rules, constraints, examples, and exceptions together so duplicates, conflicts, and merge opportunities become visible.

2. Delete
   - Remove stale constraints, duplicates, literal patches, workarounds, obsolete exceptions, and over-specific detail.

3. Replace
   - Replace brittle or example-specific wording with intent-level decision criteria.
   - Describe intended behavior and non-negotiable boundaries directly.

4. Consolidate
   - Merge rules that express the same behavior into one source of truth.

5. Add
   - Add text only when deletion, replacement, or consolidation cannot express the intended behavior.

## Validation

Before finishing, verify that the artifact has no conflicting rule and exception, duplicate source of truth, literalized user explanation, obsolete fixed limit, or example standing in for a general rule. Prefer the shortest text that preserves the required behavior.

First reorder by purpose, then delete, replace, and consolidate. Every independent rule that remains must be one whose removal, replacement, or consolidation would break the artifact's purpose.

## Output Discipline

When reporting the edit, explain:
- what was deleted
- what was replaced
- what was intentionally not added
- why the artifact now better matches the user's intent

Touch only necessary sections.
