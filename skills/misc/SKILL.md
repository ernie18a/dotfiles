---
name: misc
description: Manual invocation only
---

# Misc

## Role

Refine editable artifacts by formalizing intent, normalizing structure, and adding only the minimum text needed to preserve the user's required invariants.

## Core Principle

1. **Anti-Hallucination Boundary**: Do not define quality with subjective adjectives. Express constraints as explicit decision rules, invariants, invalid states, or logic boundaries.
2. **Intent as Evidence**: Treat user wording as raw evidence of intended behavior, then translate it into deterministic rules instead of copying phrasing literally.
3. **Single Source of Truth**: When multiple rules govern the same behavior, unify them into one authoritative rule.
4. **Minimal Extension**: Add text only when the intended invariants cannot be expressed by reordering, replacement, or consolidation.

## Premise Check

Before editing, define:
- $I$ (Invariants): the non-negotiable behaviors or outcomes the artifact must preserve
- $U$ (User request): the requested delta
- $A$ (Artifact text): the current text
- identify whether the transition from $A$ to $A'$ requires reordering, substitution, consolidation, or extension

If the task is primarily to reduce text by removal testing, use `subt3` instead.

## Edit Order

Execute edits using the following flow:

1. Reorder by Topology
   - Group rules, exceptions, and constraints that govern the same system state or invariant together.

2. Replace (Formalization)
   - Replace subjective descriptions with explicit decision rules, logical invariants, invalid states, or negative constraints.
   - Replace brittle examples with generalized boundaries when the example is only standing in for a rule.

3. Consolidate (Unification)
   - Merge overlapping or duplicated rules into a single source of truth.

4. Add (Minimal Extension)
   - Append text only when the target invariants cannot be satisfied through reordering, replacement, or consolidation.

## Validation

The editing process terminates when:
1. All preserved behaviors in $I$ are still expressed.
2. No subjective or aesthetic wording remains where a formal rule is required.
3. No duplicate or overlapping rule remains for the same behavior.
4. No added text exists that could have been replaced by a clearer rule or consolidation.

## Handoff Report

When reporting the edits, list strictly:
1. **Reordered**: text moved to align related rules under the same invariant.
2. **Replaced**: mappings from subjective or brittle wording to formalized rules.
3. **Consolidated**: rules merged into one source of truth.
4. **Added**: text appended because the invariant could not otherwise be expressed.
5. **Invariant Status**: why the refined artifact still preserves all necessary conditions.
