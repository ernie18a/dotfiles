---
name: norm2
description: Create a compact contract skeleton before using os when raw intent has unstable paths, implicit technical seams, broad concepts, or hidden-memory risk; preserves invariants, execution boundaries, adapter seams, verification oracles, and local dependencies without writing a full handoff.
---

# Norm2

## Role

Convert raw intent into a compact contract skeleton for a later handoff generator such as `os`.

Use it when direct handoff generation would rely on hidden memory, stale paths, broad concept text, or inferred technical seams.

`norm2` preserves constraints that determine whether the later handoff can become executable. It does not write the implementation plan.

## Output

Write one standalone `normNN.md`-style document. It must be short enough to read before `os`, and explicit enough that `os` does not need hidden memory to recover critical constraints.

## Required Sections

### Goal

- terminal outcome
- current smallest executable slice

### Contract Invariants

List behavior that must not be lost. Prefer decision rules over background.

### Execution Boundaries

Define file placement, runtime, and safety boundaries. Every relative path must state its base directory.

### Adapter Seams

Name external seams that must be mocked, injected, or asserted by tests. Do not invent exact API names unless the source provides them or the next step is allowed to verify installed APIs.

### Verification Oracle

Define what proves the slice works. Include what tests must assert, not only the command to run.

### Inputs And Local Dependencies

List required local files and their role: authoritative contract, local reference only, runtime config, or fixture. If a file may move with the project, use a relative path and state the base.

### Forbidden

List only actions that would change the slice or create false success.

### Stop

Stop when the slice cannot remain true without changing scope.

## Rules

- `norm2` is not a full handoff.
- Do not create phase-by-phase implementation steps unless phase order is itself a contract.
- Preserve implementation hooks that materially affect verification.
- Remove stale fixed paths or convert them into local dependencies with a stated base.
- If a detail matters to `os`, put it in the contract skeleton.
- Keep one source of truth for each dependency.

## Default Shape

```md
# normNN

## Goal

- terminal:
- current:

## Contract Invariants

- ...

## Execution Boundaries

- source root:
- target root:
- state/receipt:
- API/model:
- writes:

## Adapter Seams

- ...

## Verification Oracle

- ...

## Inputs And Local Dependencies

- ...

## Forbidden

- ...

## Stop

- ...
```
