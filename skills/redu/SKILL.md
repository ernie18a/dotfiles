---
name: redu
description: Manual invocation only
---

# Ablation Minimality

## Definition

Let $S = \{e_1, ..., e_n\}$ be the current set of elements composing the artifact.
Let $F(S)$ be a binary function: the target system operates correctly given $S$.

$S$ is minimal iff:

$$\forall e_i \in S,\quad F(S \setminus \{e_i\}) = \text{false}$$

That is, every remaining element is load-bearing. $S$ is not minimal if any single
element can be removed while $F$ remains true.

## Procedure

For each $e_i \in S$, one at a time:

1. Remove $e_i$.
2. Evaluate $F(S \setminus \{e_i\})$.
3. If true → $e_i$ was not load-bearing. Leave it removed. Update $S := S \setminus \{e_i\}$.
4. If false → restore $e_i$.

Repeat over the full set until one full pass produces zero removals.

## Termination

Stop when:

$$\forall e_i \in S,\quad F(S \setminus \{e_i\}) = \text{false}$$

At this point $S$ is a minimal generating set for $F$. No further reduction is attempted
by this skill — reaching this state is the definition of done, not a heuristic estimate of it.

## Output

List only:
- **Removed**: elements where step 3 applied.
- **Retained**: elements where step 4 applied, i.e. $F(S \setminus \{e_i\}) = \text{false}$ was observed for each.

No other commentary. A retained element requires no justification beyond having failed
the removal test — the test result is the justification.
