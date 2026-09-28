---
name: util2
description: Manual invocation only
---

# Util2

For each candidate addition, net utility is its expected improvement toward the stated goal minus all costs it introduces, relative to the retained candidates.

1. Understand all candidates and their dependencies, overlap, and combined effects before scoring.
2. Evaluate dependent or complementary candidates together when their value depends on joint inclusion.
3. Score the available additions by expected net utility and retain the highest positive one.
4. After each addition, update affected scores relative to the retained candidates. Repeat until no assessable addition has positive net utility.
5. Omit nonpositive additions without discarding other candidates solely because of their earlier ranking.
6. When information is insufficient to determine net utility, state the missing input and leave that addition unresolved. Continue evaluating the others.
