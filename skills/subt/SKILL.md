---
name: subt
description: Manual invocation only
---

# Subt

## Role

Apply Minimum Description Length (MDL) compression to text and descriptions. Preserve the necessary and sufficient conditions of the user's intent, remove redundant constraints through delta debugging (ddmin), and return the smallest text state that satisfies the preserved intent.

The text carrier may be an existing document, conversation state, concept, requirement, or any other user-provided description.

## Core Principle (Formalized Intent)

1. **Intent as Evidence**: Treat user wording as evidence of intended invariants. Translate it into deterministic decision rules instead of preserving wording that does not affect the intent.
2. **Necessary and Sufficient Conditions**: Retain a rule only when removing it can change the required behavior or outcome. Otherwise remove it as redundant.
3. **Formal Boundary**: Express quality and validity through explicit invariants, conditions, or prohibited states. Do not use subjective or unformalized descriptors as requirements.
4. **Uncertainty Boundary**: Do not convert missing information into intent. Preserve unresolved points or identify them as required input.

## Premise Check (Initial State Definition)

Before transforming the carrier, define:

- $I$ (Invariants): Behaviors, outcomes, and constraints that must remain true.
- $U$ (User request): The requested change or transformation.
- $C$ (Text carrier): The source context, such as a document, conversation, concept, requirement, or description.
- $A$ (Current text state): The text available in $C$.
- $A'$ (Target text state): The shortest text that satisfies $I$ after applying $U$.

Determine whether $A$ to $A'$ requires deletion, replacement, consolidation, extension, or no change. If no carrier or intent can be identified, request the missing input.

## Edit Order (Compression Algorithm)

Execute this sequence on text units, regardless of whether the carrier is a file or conversation:

1. **Reorder by Topology**: Group statements governing the same invariant or state to expose overlap and contradiction.
2. **Delete (ddmin minimization)**: Test removable subsets against $I$. Delete each subset whose removal leaves $I$ satisfied.
3. **Replace (Formalization)**: Convert implicit, subjective, or unstable wording into explicit conditions, invariants, or prohibited states.
4. **Consolidate (Unification)**: Merge overlapping statements into one source of truth.
5. **Add (Minimal Extension)**: Add text only when $I$ cannot be satisfied through the preceding operations. New text must derive from $U$ or explicitly identified required input.

## Validation (Compression Completion)

End only the compression pass, not the carrier task. If $A'$ identifies a concrete, in-scope next action required by $I$, execute it before handoff. Complete compression only when:

1. $A'$ cannot be shortened without violating $I$.
2. Every remaining statement is necessary for $I$ or directly represents $U$.
3. No remaining requirement depends on subjective or unformalized quality terms.
4. Unresolved information is distinguished from established intent.

## Handoff Report (Output Contract)

Report strictly:

1. **Deleted ($D$)**: Text removed because it was redundant or outside $I$.
2. **Replaced ($R$)**: Text transformed into explicit invariants or decision rules.
3. **Not Added ($N$)**: Requested text not added because $I$ was already satisfied.
4. **Invariant Status**: The reason $A'$ preserves each necessary condition in $I$.
