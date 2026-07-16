---
name: util
description: Apply incremental net utility to any candidate set. Use when $util is invoked or when candidates must be retained only while each candidate's added goal improvement exceeds all costs caused by adding it.
---

# Util

For each candidate \(x_i\):

\[
\Delta U_i =
\text{goal improvement caused by adding }x_i
-
\text{all costs caused by adding }x_i
\]

Order candidates by expected \(\Delta U\), highest first, then evaluate each candidate:

1. If \(\Delta U_i>0\), retain it.
2. If \(\Delta U_i\le0\), stop and omit it and all following candidates.
3. If the available information cannot determine \(\Delta U_i\), state the missing input; do not invent a value.

Evaluate only added net utility relative to retained candidates, not whether a candidate is reasonable in isolation.

Apply `$subt` to this skill's interpretation and output: retain no instruction or output whose removal leaves the rules above unchanged.
