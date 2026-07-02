---
name: subt2
description: Use when compressing, refining, or simplifying any prompt, script, spec, or policy by applying Minimum Description Length (MDL) and delta debugging (ddmin) principles. Replaces subjective adjectives with formalized concepts to prevent LLM comprehension hallucination.
---

# Subt2

## Role

Apply Minimum Description Length (MDL) compression to editable artifacts, preserving necessary and sufficient conditions of the user's intent while removing redundant constraints through delta debugging (ddmin).

## Core Principle (Formalized Intent)

1. **Anti-Hallucination Boundary**: Never use subjective adjectives (e.g., "clean", "over-engineered", "simple") to define quality. Instead, express quality constraints via formalized concepts (e.g., algorithmic complexity, logic boundaries, strict invariants).
2. **Intent as Evidence**: Treat user wording as raw data representing intended system invariants. Translate the wording into deterministic decision rules rather than transcribing the exact phrasing.
3. **Necessary and Sufficient Conditions**: A rule or constraint must only exist if its removal alters the target system's behavior. If behavior remains unchanged, the rule is redundant and violates the MDL principle.

## Premise Check (Initial State Definition)

Before editing, define the system using the following formal elements:
- $I$ (Invariants): The non-negotiable behaviors/outcomes the artifact must preserve.
- $U$ (User request): The delta change requested by the user.
- $A$ (Artifact text): The current state of the text.
- Identify whether the transition from $A$ to $A'$ requires subset deletion, substitution, or extension.

## Edit Order (Compression Algorithm)

Execute edits using the following deterministic flow:

1. **Reorder by Topology**:
   - Group rules, exceptions, and constraints that govern the same system state or invariant together. This exposes logical overlaps and contradictions.

2. **Delete (ddmin minimization)**:
   - Apply a mental delta debugging algorithm (`ddmin`): Group text blocks into subsets. For each subset, test if the core invariants ($I$) still hold if deleted.
   - Delete any subset where $I$ remains satisfied without it. This removes obsolete patches, literal examples, and redundant constraints.

3. **Replace (Formalization)**:
   - Replace subjective descriptions with explicit decision rules, logical invariants, or negative constraints (e.g., "Define invalid states" instead of "Be careful not to...").
   - Replace brittle examples with mathematically or logically defined boundaries.

4. **Consolidate (Unification)**:
   - Merge overlapping rules into a single source of truth to minimize the total description length of the artifact.

5. **Add (Minimal Extension)**:
   - Append text ONLY when the target invariants ($I$) cannot be satisfied via reordering, deletion, replacement, or consolidation.

## Validation (Termination Condition)

The editing process terminates when:
1. **MDL Achieved**: The artifact cannot be shortened further without violating the core invariants ($I$).
2. **Necessary Condition Satisfied**: Every remaining sentence/rule $r \in A'$ is necessary ($\neg r \implies \neg I$).
3. **No Subjective Terms**: The final text contains zero subjective, aesthetic, or un-formalized descriptors that could trigger LLM compliance hallucination.

## Handoff Report (Output Contract)

When reporting the edits, list strictly:
1. **Deleted ($D$)**: The exact text blocks removed (violating MDL).
2. **Replaced ($R$)**: The mapping of subjective terms/brittle logic to formalized invariants.
3. **Not Added ($N$)**: Requested elements that were bypassed because existing rules already cover them.
4. **Invariant Status**: Proof of why the compressed text preserves all necessary conditions.
