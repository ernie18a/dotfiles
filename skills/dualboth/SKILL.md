---
name: dualboth
description: "Prepare shared INPUT/*.md briefs for either /g/app/dual or /g/app/dual_agy. Use when Codex should turn a user goal, repo state, unresolved issue, or handoff notes into a runtime-neutral planner-worker brief with explicit scope, verification, escalation, and completion criteria."
---

# Dual Both

## Purpose

Create one runtime-neutral task brief for `/g/app/dual` or `/g/app/dual_agy`.

Select the named runtime before preparing the brief. If none is named, default to `/g/app/dual`. Generate the same `INPUT/*.md` task contract for either target.

The runtime owns invocation, protocol parsing, state, logs, and recovery. This skill owns task strategy:

- write `INPUT/*.md`
- define goal, scope, validation, stop rules, and escalation
- keep project-specific semantics out of the runtime

## Output

Create one or more markdown files under the target project's `INPUT/`.

Default:

```text
INPUT/00-brief.md
```

Use multiple files only when sorting or reuse improves:

```text
INPUT/00-brief.md
INPUT/10-context.md
INPUT/20-policy.md
```

Keep `INPUT/*.md` short. Both runtimes load every input file, so place long context outside `INPUT/` and reference it through a Context Index.

## Source Handling

Treat user-named material as the source of truth. Convert it into the `INPUT/*.md` contract. Preserve root-relative paths: keep `STATUS.md` as `STATUS.md` unless the source explicitly says `INPUT/STATUS.md`.

Separate terminal goals from the current batch. Do not mark the terminal goal complete merely because the next batch succeeds. If terminal completion cannot be inferred, state that gap in the brief.

## Fit Check

Before writing input files, verify:

- The task benefits from planner guidance and worker execution.
- The scope and stop conditions are explicit.
- The worker can execute a batch without chat history.
- Required project context has stable paths.
- Completion evidence is known or explicitly unresolved.

For a direct one-shot fix, state that a planner-worker runtime may add unnecessary overhead and provide a smaller direct handoff instead.

## Context And Progress

Add a compact Context Index when the task has more context than the planner needs every turn:

```md
## Progress

- [x] P01: identify failing auth boundary
- [ ] P02: patch middleware
- [ ] P03: verify tests

## Context Index

- C01 `STATUS.md`: current known state. Read before planning a new phase.
- C02 `CONTEXT/10-auth.md`: auth contract. Read only for auth-related batches.
- C03 `CONTEXT/20-tests.md`: test map. Read before choosing verification commands.
```

Record durable project facts in `STATUS.md` or another indexed file. Do not encode session IDs, thread behavior, runtime state paths, logs, or parser recovery rules in `INPUT/*.md`.

## Brief Requirements

Include:

- terminal and current-batch goals
- current state and unresolved work
- durable progress checklist
- context index for large references
- allowed and forbidden scope
- immutable contracts
- verification commands or limits
- escalation policy
- completion criteria
- report expectations

Avoid chat dumps, long logs, source-file copies, runtime implementation details, and duplicated runtime rules.

## Planner Review

Require the planner to use worker reports, changed files, verification output, unresolved blockers, and completion criteria for the next decision.

Require the planner to shrink or clarify a blocked local batch before retrying. Require a blocked decision with evidence when repeated attempts create new errors without verified progress. Do not make the planner take over implementation unless the user explicitly requests it.

## Minimal Template

```md
# task brief

## Goal

- terminal:
- current batch:

## Current State

- source of truth:
- known progress:
- unresolved work:

## Progress

- [ ] P01:
- [ ] P02:

## Context Index

- C01 `path`: when to read it.
- C02 `path`: when to read it.

## Scope

Allowed:
- ...

Forbidden:
- ...

## Contracts

- input:
- output:
- error:
- invariants:

## Verification

- allowed commands:
- forbidden commands:
- expected evidence:

## Escalation Policy

- If worker reports `done`, review current state and Completion Criteria before stopping.
- If the current batch is complete but Completion Criteria are not met, issue the next batch from remaining source-of-truth work.
- If worker reports `blocked` on a local implementation issue, shrink or clarify the batch first.
- If revised work remains blocked, choose a smaller batch, return `blocked`, or ask for human input.
- If attempts produce only new errors without verified progress, stop retrying and return concrete evidence.
- If the next action violates Scope, Contracts, or command restrictions, return `blocked`.

## Completion Criteria

- terminal success:
- required evidence:
- conditions that are not sufficient by themselves:

## Report Expectations

- summary: one short delta for this batch, naming the relevant `Pxx` id when available
- changed files: project-relative paths only
- tests: command, status, short output summary only
- unresolved issue: blocker id, failing behavior, next smallest action
- assumptions: only assumptions that affect the next plan
```

## Path Semantics

Resolve paths inside briefs from the target project root. Use `INPUT/...` only for input files. Use root-relative paths such as `STATUS.md`, `src/foo.rs`, or `tests/foo.rs` for project context and implementation files.

## Quality Bar

Prefer the smallest useful input set. Remove anything that does not affect planner guidance, worker execution, validation, stopping, or escalation.
