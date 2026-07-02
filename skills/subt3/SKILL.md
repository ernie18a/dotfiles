---
name: subt3
description: Use when reducing any prompt, script, spec, policy, or other editable text by deletion only. Applies delta debugging (ddmin) and Minimum Description Length (MDL) to remove non-load-bearing text while preserving the user's required invariants. Does not rewrite, reorder, or add content.
---

# Subt3

## Role

Reduce editable artifacts by deletion only, preserving the necessary and sufficient conditions of the user's intent.

## Core Principle

1. **Deletion Only**: The allowed transformation from $A$ to $A'$ is removal of text. Do not rewrite, reorder, consolidate, or add content.
2. **Intent as Invariants**: Treat the user's request as evidence for the non-negotiable behaviors the artifact must preserve.
3. **Load-Bearing Test**: A sentence, rule, example, or section may remain only if removing it would violate the preserved invariants.

## Premise Check

Before editing, define:
- $I$ (Invariants): the required behaviors or outcomes that must survive reduction
- $U$ (User request): the requested delta or target behavior
- $A$ (Artifact text): the current text
- $E = \{e_1, ..., e_n\}$: the candidate removable elements in $A$

If the request requires rewriting, reordering, consolidation, or extension, this skill is not the correct tool.

## Procedure

1. Partition
   - Split $A$ into candidate elements $E$ at the sentence, rule, list-item, paragraph, or section level.

2. Remove
   - For each subset or element, test whether $I$ still holds if that text is deleted.
   - Delete any text whose removal does not violate $I$.

3. Repeat
   - Continue passes until no remaining element can be removed without violating $I$.

## Validation

Stop when all remaining elements are load-bearing:

$$\forall e_i \in E,\quad I(A' \setminus \{e_i\}) = \text{false}$$

At termination:
1. The artifact is shorter than the original.
2. Every remaining element is necessary for preserving $I$.
3. No non-load-bearing text remains.

## Output

List only:
1. **Removed**: text deleted because $I$ remained satisfied without it.
2. **Retained**: text that failed the removal test.
3. **Invariant Status**: why the reduced artifact still preserves $I$.
