---
name: alig
description: Use Alignment before authoring, editing, or compressing any prompt, skill spec, or policy that will later be executed by an LLM when the source material contains subjective or abstract descriptors without a formal definition. Formalizes those descriptors into testable invariants before skill authoring. Domain-agnostic; produces no domain-specific constants.
---

# Intent Formalization

## Role

Convert source wording into testable invariants before any rule, threshold, or instruction is written into the target artifact. This skill runs upstream of MDL compression (`subt2`); `subt2` assumes invariants already exist.

## Core Principle (Formalized Intent)

1. **No Unsourced Constants**: Any threshold, count, or category used to operationalize a descriptor must be derivable from an explicit clause in source wording $U$. If it is not derivable, reject it.
2. **Compliance Is Not Evidence**: A claim that an artifact satisfies a descriptor is invalid unless paired with the invariant clause it was tested against.
3. **Predicates Only**: Restate each descriptor as a testable predicate over the artifact; do not leave it as a prohibition or open-ended negative statement.

## Premise Check (Initial State Definition)

Before authoring the target artifact, define:
- $U$ (User wording): The raw source instruction, containing zero or more subjective descriptors $d_1, ..., d_n$.
- $I$ (Invariants): For each $d_k$, either a testable predicate derived strictly from clauses in $U$, or an explicit unresolved flag if no such derivation exists.
- $A'$ (Target artifact): Not yet authored. No rule may be written into $A'$ unless it traces to $I$.

## Edit Order (Formalization Algorithm)

1. **Extract**:
   - Enumerate every subjective or abstract descriptor $d_k$ in $U$. A descriptor is any term whose satisfaction cannot be checked without further interpretation.

2. **Derive**:
   - For each $d_k$, search $U$ for a clause that constrains its meaning.
   - If found: construct $I_k$ as a predicate over that clause only, using no term, value, or category absent from $U$.
   - If not found: mark $d_k$ unresolved. Do not substitute an assumed predicate, constant, or example.

3. **Test (Necessity)**:
   - Retain a rule only if deleting it would falsify some $I_k$. Delete any rule that does not trace to an $I_k$.

4. **Prohibit-to-Predicate Conversion**:
   - Rewrite any "$A'$ must not exhibit $X$" statement into a predicate form derived from $U$ before accepting it into $I$.

5. **Halt on Unresolved**:
   - If any $d_k$ remains unresolved after step 2, do not author the governed portion of $A'$; report the gap instead of filling it.

## Validation (Termination Condition)

Formalization is complete when:
1. Every $d_k \in U$ maps to either a derived $I_k$ or an explicit unresolved flag.
2. No member of $I$ contains a value, category, or threshold absent from $U$.
3. No member of $I$ is phrased as a prohibition.
4. $A'$ authoring does not begin for any portion whose governing $d_k$ is unresolved.

## Handoff Report (Output Contract)

1. **Resolved ($I$)**: Each $d_k \to I_k$, with the clause of $U$ it was derived from.
2. **Unresolved ($d$)**: Descriptors with no derivable clause in $U$; authoring withheld pending clarification.
3. **Rejected Constants**: Any threshold considered and discarded under Core Principle 1, with the reason no clause in $U$ supported it.
4. **Evidence Rule**: Every statement in this report cites a clause of $U$ or an $I_k$ test result.
