---
name: util
description: Manual invocation only
---

# Util

For each candidate \(x_i\):

\[
\Delta U_i =
\text{goal improvement caused by adding }x_i
-
\text{all costs caused by adding }x_i
\]

Order candidates by expected \(\Delta U\), highest first, and evaluate each only by its added net utility relative to retained candidates:

1. If \(\Delta U_i>0\), retain it.
2. If \(\Delta U_i\le0\), stop and omit it and all following candidates.
3. If the available information cannot determine \(\Delta U_i\), state the missing input and leave the candidate unresolved.
