---
name: normlg
description: "Run a two-pass pipeline for raw requests, feature lists, enable*.md files, or broad plans that should become LangGraph runtime entries: first create a normalized execution spec, then compile only that spec into one lgNN.md entry. Use when direct lg would be too shallow or would copy raw feature inventory into an LG format."
---

# NormLG

## Role

Create a forced two-pass path from raw intent to an LG runtime entry:

```text
raw source -> normNN.md -> lgNN.md
```

Treat this as a pipeline, not a merged shortcut. The intermediate `normNN.md` is required.

## Boundary

`normlg` may:
- read the raw source and directly relevant project files needed to shape execution boundaries
- create the next `normNN.md`
- create the next `lgNN.md` from `normNN.md`
- read the raw source again only to verify that `normNN.md` did not drop a material constraint

`normlg` must not:
- produce `lgNN.md` directly from the raw source
- skip the `normNN.md` file
- use raw feature-list items as immediate `Next Action`
- continue to LG if the normalized route is not `lg`
- execute the task, mutate runtime state, or claim completion

## Workflow

1. Read source.
   Inspect the requested raw file, feature list, broad plan, or user request. If code-affecting scope is known, inspect directly related code contracts before fixing scope.

2. Write `normNN.md`.
   Create the next numbered normalized execution spec. It must include:
   - terminal goal
   - current slice
   - allowed and forbidden scope
   - inputs
   - evidence
   - verification
   - stop conditions
   - route recommendation

3. Gate.
   Continue only if `normNN.md` recommends `lg`. If it recommends direct implementation, `os`, or `dual`, stop and report that route.

4. Compile `lgNN.md`.
   Use `normNN.md` as the primary input. Read the raw source only for constraint checking. Fill the LG entry contract with the smallest executable next action and audit-ready completion criteria.

5. Check for shallow conversion.
   Before finishing, verify that:
   - `lgNN.md` references `normNN.md` as an input
   - `Next Action` is narrower than the terminal goal
   - terminal feature lists remain terminal or future scope, not immediate work
   - evidence and completion criteria can reject false success

## Output

Report only:
- created `normNN.md`
- created `lgNN.md`, or the route that stopped LG creation
- what was tightened or removed from the raw source
- unresolved blockers, if any
- the command to run next, if known
