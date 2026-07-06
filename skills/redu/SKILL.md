---
name: redu
description: Manual invocation only
---

# Reduction Boundary

## Role

Identify the minimum set of conditions required for a target behavior to still pass
its stated success check.
Use this for code, documents, requirements, interviews, plans, arguments, or any
discussion where the question is: "What can be removed before the target fails?"

## Definition

Let $T$ be the target behavior, decision, output, or validity condition being
evaluated.
Let $P$ be the success check for $T$: the observable condition that must remain true.
Let $S = \{e_1, ..., e_n\}$ be the current set of candidate conditions, facts,
constraints, steps, resources, statements, or implementation elements that may
contribute to $T$.
Let $F(S, P)$ be a binary function:

$$
F(S, P) =
\begin{cases}
\text{true}, & P \text{ remains satisfied given } S \\
\text{false}, & P \text{ fails or becomes undecidable given } S
\end{cases}
$$

$S$ is minimal for $T$ iff:

$$\forall e_i \in S,\quad F(S \setminus \{e_i\}, P) = \text{false}$$

Every remaining $e_i$ is load-bearing. If any $e_i$ can be removed while
$F(S \setminus \{e_i\}, P)$ remains true, that $e_i$ is not required for $T$.

## Procedure

1. Define $T$ as a behavior, decision, output, or validity condition.
2. Define $P$ as the check that proves $T$ still works.
3. Define $S$ as the current candidate set affecting $T$.
4. For each $e_i \in S$, one at a time:
   - Remove or ignore $e_i$.
   - Evaluate $F(S \setminus \{e_i\}, P)$.
   - If true, mark $e_i$ as removable and update $S := S \setminus \{e_i\}$.
   - If false, mark $e_i$ as retained.
5. Repeat until one full pass produces zero removals.

## Interpretation Rules

1. If $T$ is not defined, ask for or infer the smallest target from context.
2. If $P$ is not defined, ask for or infer the success check from context.
3. If $S$ is not explicitly listed, derive candidate elements from the user's text.
4. If $F$ cannot be evaluated from available information, mark the result as
   undecidable instead of guessing.
5. Do not treat preference, familiarity, or convention as load-bearing unless
   removing it changes $F(S, P)$.
6. Do not reduce below the point where $P$ fails, becomes ambiguous, or cannot be
   evaluated from the user's stated intent.

## Termination

Stop when:

$$\forall e_i \in S,\quad F(S \setminus \{e_i\}, P) = \text{false}$$

At this point $S$ is the minimum viable condition set for $T$ under $P$. Further
reduction is invalid because it makes $P$ false or undecidable.

## Output

When editing an artifact, list:
- **Removed**: elements where $F(S \setminus \{e_i\}, P) = \text{true}$.
- **Retained**: elements where $F(S \setminus \{e_i\}, P) = \text{false}$.
- **Undecidable**: elements where $F$ cannot be evaluated from available information.

When discussing a concept or requirement, answer with:
- **Target ($T$)**: the behavior, decision, output, or validity condition being protected.
- **Success Check ($P$)**: the observable check that must remain true.
- **Minimum Set ($S$)**: the retained load-bearing conditions.
- **Removable**: conditions that can be removed without changing $T$.
- **Failure Boundary**: the first condition whose removal makes $P$ false or undecidable.
