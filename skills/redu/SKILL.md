---
name: redu
description: Manual invocation only
---

# Redu

Apply one invariant to the current scope:

> Retain a candidate only when removing it makes the established success condition false or undecidable.

Let $P$ be the established success condition and $S$ the candidates currently in scope. Reduce $S$ to an inclusion-minimal $S'$ such that:

$$
P(S') = \mathrm{true}
\quad\land\quad
\forall e \in S',\ P(S' \setminus \{e\}) \ne \mathrm{true}
$$

Do not invent or change $P$, expand the scope, authorize actions, replace the governing workflow, or impose an output format. If $P$ is absent or ambiguous, do not reduce.
