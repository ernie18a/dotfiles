---
name: redu2
description: Use for deletion-only reduction of any finite set of elements, including rules, sections, functions, steps, parameters, examples, prompts, specs, policies, or workflows. Apply when the user wants to remove redundancy, find non-load-bearing parts, shrink an artifact, or reach a minimal set while preserving an explicit behavior, invariant, test, contract, or fitness function.
---

# Redu2

## Role

Reduce a finite set of elements by deletion only until every remaining element is necessary for preserving the target condition.

This skill generalizes text reduction. A text artifact is one possible input; its candidate elements may be sentences, list items, rules, paragraphs, examples, or sections.

## Model

Define:

- $S = \{e_1, ..., e_n\}$: the current candidate elements
- $T$: the target condition that must remain true
- $F(S)$: the evaluation that returns true when $S$ still satisfies $T$

$S$ is minimal iff:

$$\forall e_i \in S,\quad F(S \setminus \{e_i\}) = \text{false}$$

Every retained element must be load-bearing. If removing an element leaves $F$ true, that element is redundant under $T$.

## Preconditions

Use this skill only when:

1. The input can be represented as a finite set of candidate elements.
2. The target condition $T$ can be stated as a behavior, invariant, test, contract, output requirement, or fitness function.
3. The requested transformation is deletion only.

Do not use this skill when the task requires rewriting, reordering, merging, or adding information. Those operations may be separate follow-up work, but they are outside this skill.

## Target Extraction

Before removing elements:

1. Treat the user's wording as evidence for $T$, not as text that must be copied.
2. State $T$ in executable or falsifiable terms when possible.
3. If $T$ is not explicit enough to evaluate removals, report the missing condition instead of inventing one.

For text artifacts, $T$ is usually the required meaning, behavior, policy boundary, or response contract. For code, workflows, or parameter sets, $T$ may be passing tests, preserved behavior, required output, or an explicit acceptance condition.

## Procedure

1. Partition

   - Enumerate candidate elements $S$ at the smallest level that can be removed without changing unrelated elements.

2. Test Removal

   - For each $e_i$, evaluate $F(S \setminus \{e_i\})$.

3. Delete or Restore

   - If $F(S \setminus \{e_i\}) = \text{true}$, remove $e_i$ and update $S := S \setminus \{e_i\}$.
   - If $F(S \setminus \{e_i\}) = \text{false}$, retain $e_i$.

4. Repeat

   - Continue full passes until one full pass removes zero elements.

## Validation

Stop only when:

1. $F(S)$ is true.
2. For every remaining $e_i$, $F(S \setminus \{e_i\})$ is false.
3. No retained element is justified by preference, wording familiarity, formatting convenience, or aesthetic judgment.

The result is a minimal generating set under the stated $T$, not an absolute minimum under every possible target condition.

## Output

Report only:

1. **Target Condition**: the $T$ used for removal testing.
2. **Removed**: elements deleted because $F$ remained true without them.
3. **Retained**: elements retained because removing them made $F$ false.
4. **Missing Conditions**: target conditions that were required but not provided.
