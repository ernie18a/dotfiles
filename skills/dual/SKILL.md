---
name: dual
description: "Prepare shared *NN.md briefs for /g/app/dual. Use when Codex should turn a user goal, repo state, unresolved issue, or handoff notes into a runtime-neutral planner-worker brief with explicit scope, verification, escalation, and completion criteria."
---

# Dual

## Purpose

Create one runtime-neutral task brief for `/g/app/dual`.

Select the named runtime before preparing the brief. If none is named, default to `/g/app/dual`. Generate the same `*NN.md` task contract for the target project root.

The runtime owns invocation, protocol parsing, state, logs, and recovery. This skill owns task strategy:

- write root-level `*NN.md`
- define goal, scope, validation, stop rules, and escalation
- keep project-specific semantics out of the runtime

## Output

Create one or more markdown files in the target project root.

Default:

```text
00.md
```

Use multiple files only when sorting or reuse improves:

```text
00.md
10.md
20.md
```

Keep root `*NN.md` briefs short. The runtime loads matching root files, so place long context outside the brief set and reference it through a Context Index.

## Source Handling

Generated entry briefs must pass a source-dependency check: after source requirement files are moved, archived, or deleted, the brief still contains the product contract, required inventory, scope, verification, and completion criteria. Source requirement files are extraction inputs only, not runtime dependencies, cross-check authorities, required reading, context-index entries, or recovery paths.

Extract durable requirements into the entry brief or an indexed durable state file. Do not cite source requirement files as task authority after extraction. Build the terminal goal from the complete user or product scope; when sources differ in scope, the inventory defines terminal scope and the task note defines the current batch.

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
- The generated entry passes the source-dependency check.

For a direct one-shot fix, state that a planner-worker runtime may add unnecessary overhead and provide a smaller direct handoff instead.

## Context And Progress

Entry briefs are task indexes, not history stores. Put only the state needed for planner/worker execution in the entry; summarize durable target-project progress in `STATUS.md` or an indexed state file, and treat runtime checkpoint/log files as recovery artifacts rather than task authority.

Keep target artifacts and runtime artifacts in separate namespaces. The target project owns files named in the brief, such as `STATUS.md`, `src/*`, `tests/*`, and indexed context files. The runtime owns only its checkpoint/log namespace, such as `PROGRESS/*`. Do not design briefs that require the runtime to overwrite target progress files with runtime phase, parser, provider, or recovery state.

Add a compact Context Index when the task has active state, implementation evidence, or maintained references that the planner does not need every turn:

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

Record durable project facts in `STATUS.md` or another indexed file. Do not encode session IDs, thread behavior, runtime phase state, logs, parser recovery rules, or provider status as target project facts.

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
- handoff state expectations

Avoid chat dumps, long logs, source-file copies, runtime implementation details, duplicated runtime rules, and human-facing status prose as the primary handoff.

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

- task authority:
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

## Handoff State

- summary: one short delta for this batch, naming the relevant `Pxx` id when available
- changed files: project-relative paths only
- tests: command, status, short output summary only
- blocker: only when work cannot continue within Scope; include observed evidence and exhausted alternatives
- remaining autonomous actions: next smallest in-scope actions, or empty when the terminal goal is complete
- assumptions: only assumptions that affect the next plan
```

## Path Semantics

Resolve paths inside briefs from the target project root. Use root-relative paths such as `STATUS.md`, `src/foo.rs`, or `tests/foo.rs` for project context and implementation files.

## Quality Bar

Prefer the smallest useful input set. Remove anything that does not affect planner guidance, worker execution, validation, stopping, or escalation.

## References

- `references/dual-runtime-deepseek-quirks.md` — runtime provider and no-progress guard failure patterns. Read when debugging worker workspace blindness, stale changed-files in terminal output, or false no-progress failures. Covers `response_format: json_object` + tools suppression on DeepSeek, `OBSERVED_FILES` injection, `_finish` stale-data pitfall, and blocked-worker no-progress guard fix.
