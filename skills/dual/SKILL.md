---
name: dual
description: "Prepare shared INPUT/*.md briefs for /g/app/dual. Use when Codex should turn a user goal, repo state, unresolved issue, or handoff notes into a runtime-neutral planner-worker brief with explicit scope, verification, escalation, and completion criteria."
---

# Dual

## Purpose

Create one runtime-neutral task brief for `/g/app/dual`.

Select the named runtime before preparing the brief. If none is named, default to `/g/app/dual`. Generate the same `INPUT/*.md` task contract for the target.

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

Build the terminal goal from the complete user or product scope. When a project has a requirements inventory and a narrower task note, the inventory defines the terminal goal and the task note defines the current batch. Reconcile the requirement sources before writing the Progress list; do not let one narrow source redefine the terminal goal.

## Constraint Provenance

Classify constraints before writing the brief:

- Include task requirements and target-project instructions that govern the work.
- Include runtime-neutral task contracts.
- Exclude global or user-level instruction files, including `~/.codex/AGENTS.md`, current assistant permissions, tool approvals, sandbox limits, and chat-session policies.
- Exclude runtime implementation and protocol rules.

Do not turn a temporary approval requirement into a task restriction. Under `Verification`, list commands the worker may run autonomously unless the task or target project explicitly restricts them. Do not write requirements such as "ask the user", "obtain approval", or "provide X then continue" for information the worker can inspect, derive, acquire through its available tools, or implement support for.

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

Require Smart to issue the next batch whenever the terminal goal still has source-of-truth work. A completed batch is not a completed task. Require the worker to inspect the workspace, derive existing inputs, use available tools, and exhaust bounded in-scope alternatives before returning `blocked`.

## Minimal Template

```md
# task brief

## Goal

- terminal: complete user or product outcome, not a phase or issue fix
- current batch: next bounded phase toward the terminal goal

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
- project-restricted commands:
- expected evidence:

## Escalation Policy

- Return `done` only when the terminal goal and Completion Criteria are met. If a batch is complete, issue the next batch from remaining source-of-truth work.
- Do not ask the user for clarification, approval, input, or a decision. Inspect, derive, acquire through available tools, or implement the smallest missing capability first.
- If worker reports `blocked` or `failed` on a local implementation issue, review the evidence and choose the smallest next batch or `takeover_plan`.
- If Worker retries no longer produce verified progress, use `takeover_plan`; do not return `blocked` while an in-scope Smart action remains.
- Return `blocked` only after bounded attempts demonstrate an external authority boundary and no autonomous action remains. Record blocker id, observed evidence, attempted paths, and exhausted alternatives; do not request user action.
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
