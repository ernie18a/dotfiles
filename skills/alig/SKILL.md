---
name: alig
description: Use Alignment before authoring, editing, or compressing any prompt, skill spec, or policy that will later be executed by an LLM, whenever the source material (user wording, prior draft, or requirement) contains subjective or abstract descriptors without a formal definition. Formalizes such descriptors into testable invariants prior to skill authoring, preventing the resulting skill from inheriting unverifiable constraints or self-report as evidence of compliance. Domain-agnostic; produces no domain-specific constants.
---

# Intent Formalization

## Role

Precede skill/prompt authoring with a formalization pass: convert subjective descriptors present
in the source wording into testable invariants, before any rule, threshold, or instruction is
written into the target artifact. Operates upstream of MDL compression (subt2); subt2 assumes
invariants are already known, this skill produces them.

## Core Principle (Formalized Intent)

1. **No Unsourced Constants**: A threshold, count, or category introduced to operationalize a
   descriptor is invalid unless it is derivable from an explicit clause in the source wording $U$.
   A constant with no derivation in $U$ is not a formalization — it is the same descriptor
   restated as a number, and must be rejected under the same rule that rejects the original
   descriptor.
2. **Compliance ≠ Self-Report**: A statement that an artifact "satisfies" a descriptor is a
   generation, not a verification. It is inadmissible as evidence unless paired with the specific
   invariant clause it was tested against.
3. **Predicate Over Prohibition**: A descriptor stated as a prohibition requires modeling its
   unbounded complement and is therefore untestable. Every descriptor must be restated as a
   predicate returning true/false against the artifact.

## Premise Check (Initial State Definition)

Before authoring the target artifact, define:
- $U$ (User wording): The raw source instruction, containing zero or more subjective descriptors
  $d_1, ..., d_n$.
- $I$ (Invariants): For each $d_k$, either a testable predicate derived strictly from clauses
  within $U$, or an explicit unresolved flag if no such derivation exists.
- $A'$ (Target artifact): Not yet authored. No rule may be written into $A'$ that does not trace
  to a member of $I$.

## Edit Order (Formalization Algorithm)

1. **Extract**:
   - Enumerate every subjective/abstract descriptor $d_k$ present in $U$. A descriptor is any
     term whose satisfaction cannot be checked without further interpretation.

2. **Derive**:
   - For each $d_k$, search $U$ for a clause that constrains its meaning.
   - If found: construct $I_k$ as a predicate over that clause only. $I_k$ must reference no term,
     value, or category absent from $U$.
   - If not found: mark $d_k$ as unresolved. Do not substitute an assumed predicate, constant, or
     example to fill the gap — doing so reintroduces $d_k$ under a different name.

3. **Test (Necessity)**:
   - For every rule already present in draft form (if any), apply: rule is retained iff its
     removal would falsify some $I_k$. Rules not tracing to any $I_k$ are deleted, per subt2's
     ddmin procedure.

4. **Prohibit-to-Predicate Conversion**:
   - Any $I_k$ currently stated as "$A'$ must not exhibit $X$" is rewritten as "$I_k$ holds when
     [condition derived from $U$]" before being accepted into $I$.

5. **Halt on Unresolved**:
   - If any $d_k$ remains unresolved after step 2, authoring of $A'$ does not proceed for the
     portion governed by $d_k$. Report the gap instead of authoring around it.

## Validation (Termination Condition)

Formalization is complete when:
1. Every $d_k \in U$ maps to either a derived $I_k$ or an explicit unresolved flag — none silently
   dropped, none silently filled with an assumed constant.
2. No member of $I$ contains a value, category, or threshold absent from $U$.
3. No member of $I$ is phrased as a prohibition.
4. $A'$ authoring has not begun for any portion whose governing $d_k$ is unresolved.

## Handoff Report (Output Contract)

1. **Resolved ($I$)**: Each $d_k \to I_k$, with the exact clause of $U$ it was derived from.
2. **Unresolved ($d$)**: Descriptors with no derivable clause in $U$; authoring withheld pending
   clarification, not guessed.
3. **Rejected Constants**: Any threshold considered and discarded under Rule 1 (Core Principle),
   with the reason no clause in $U$ supported it.
4. **No Bare Compliance Claims**: Every statement in this report cites a clause of $U$ or an $I_k$
   test result. A statement with neither is invalid output per Core Principle 2.
