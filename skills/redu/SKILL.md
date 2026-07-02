---
name: redu
description: Use as a deletion-only ablation-minimality pass to reduce any set of elements (functions, sections, rules, steps, parameters) to a minimal generating set under an explicit fitness function. Domain-agnostic; produces no domain-specific constants or examples.
---

# Ablation Minimality

## Role

Reduce a finite set of elements by deletion only until every remaining element is load-bearing under a binary fitness function.

## Preconditions

Define:
- $S = \{e_1, ..., e_n\}$: the current set of elements
- $F(S)$: a binary fitness function indicating whether the target system still satisfies the required behavior given $S$

This skill is valid only when $F$ is explicit enough to evaluate removals.

## Definition

$S$ is minimal iff:

$$\forall e_i \in S,\quad F(S \setminus \{e_i\}) = \text{false}$$

Equivalently, every remaining element is load-bearing.

## Procedure

For each $e_i \in S$, one at a time:

1. Remove $e_i$.
2. Evaluate $F(S \setminus \{e_i\})$.
3. If true → $e_i$ was not load-bearing. Leave it removed. Update $S := S \setminus \{e_i\}$.
4. If false → restore $e_i$.

Repeat over the full set until one full pass produces zero removals.

## Termination

Stop after a full pass with zero removals. At that point:

$$\forall e_i \in S,\quad F(S \setminus \{e_i\}) = \text{false}$$

$S$ is a minimal generating set for $F$.

## Output

List only:
- **Removed**: elements where step 3 applied.
- **Retained**: elements where step 4 applied.

No other commentary. A retained element requires no justification beyond having failed the removal test.
