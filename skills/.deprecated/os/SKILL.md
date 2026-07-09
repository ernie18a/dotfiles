---
name: os
description: Manual invocation only
---

# os Handoff

Create one `osNN.md` code-implementation handoff for a downstream code executor that edits files.
The handoff is for writing code only. It is invalid if it is a status report,
architecture report, completion report, or architecture-only plan.
Do not ask the executor to redesign requirements, infer hidden product intent,
or expand runtime behavior.

Before writing:

1. Read the user request and project's governing instructions.
2. For code-affecting work, inspect the directly related code before writing the handoff; use code facts instead of documents, summaries, or assumptions.
3. Use inspected code facts to define the bounded implementation that satisfies the requested runtime behavior.
4. Resolve choices the executor would otherwise infer: target files, behavior boundary, forbidden changes, and local choice rules.
5. Stop inspecting when additional code facts no longer change Scope, contracts, or Phase Actions.
6. Include only facts, decisions, or choice rules whose removal would change Scope, contracts, or Phase Actions.
7. If implementation choices remain, choose only the smallest local detail needed to satisfy explicit constraints.
8. If more than one valid direction remains, write the executor-facing decision rule and boundaries instead of a fixed internal sequence.

Handoff rules:
- Keep one main goal and divide work into concrete code-edit phases.
- State allowed and forbidden exact paths, behaviors, and contracts.
- Make the handoff self-contained: the executor can complete the requested code work using only the handoff. If removing prior conversation or references makes the handoff insufficient, extract the missing contracts into the handoff.
- For system-scale work, define the bounded implementation with its required input, output, state transition, and failure contracts.
- Forbidden scope may include only alternate providers, extra modes, broad refactors, or behavior outside the requested runtime boundary.
- Every file or directory created by the handoff must have an exact relative path. A handoff is invalid if any path can be derived from a command name, workspace basename, entry basename, or state directory name without a collision rule.
- If a command name equals the workspace root basename, executable files must be placed under `bin/` and generated state must be placed under a dot-prefixed state directory.
- The handoff defines code changes and runtime completion behavior. Include validation steps only when the user request requires validation work as part of the deliverable.
- Reject architecture, module lists, dependency plans, phase sequences, or abstractions that are not required to decide contracts or behavior boundaries.

Name handoffs incrementally: `os01.md`, `os02.md`.

## `osNN.md` Template

```md
# osNN

## Goal

- requested behavior:
- execution boundary:

## Scope

Allowed:
- exact relative paths:
- behaviors:
- contracts:

Forbidden:
- exact relative paths:
- behaviors:
- contracts:

## Phases

### Phase N: 名稱

Action:
- 需要完成什麼。

## Completion

- Reply exactly `DONE` when the requested code work is complete.

```
