---
name: stts
description: Manual invocation only
---

# STTS

Remove work and content that do not improve the requested goal enough to justify their costs.

Treat every contemplated or retained unit as a candidate \(x_i\), regardless of whether it is an action, implementation, sentence, explanation, constraint, or other contribution. For an existing unit, evaluate retaining it as an addition to the reconstructed result.

First establish the requested goal and its required invariants, constraints, and supported inputs. Decompose the target and proposed work into candidate units, resolve overlap and conflict, and consolidate units that make the same contribution.

For each candidate:

\[
\Delta U_i =
\text{goal improvement caused by retaining }x_i
-
\text{all costs caused by retaining }x_i
\]

Order candidates by expected \(\Delta U\), highest first, and evaluate each only by its added net utility relative to the candidates already retained:

1. If \(\Delta U_i>0\), retain it.
2. If \(\Delta U_i\le0\), omit it and all following candidates.
3. If the available information cannot determine \(\Delta U_i\), state the missing input and leave the candidate unresolved; do not invent a value.

Reconstruct the result from the retained units within the target's existing abstractions and structure. Do not preserve or reject a unit merely because it is conventional, reasonable in isolation, part of the original, or belongs to a particular medium. Preserve it only when its incremental contribution justifies its full cost.
