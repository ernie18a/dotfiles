---
name: dual2
description: Compile user requests, rough specs, robustness notes, repo state, unresolved issues, or handoff notes into root-level dualNN.md task briefs for /g/app/dual. Use when Codex must create a runtime-ready planner-worker contract with explicit goal, current batch, scope, contracts, verification, escalation, and completion criteria.
---

# Dual2

Create `/g/app/dual` entry briefs. Convert messy input into a concrete task contract the runtime can execute without chat history.

## Runtime Boundary

Target runtime: `/g/app/dual`.

The runtime owns:

- provider invocation
- planner and worker JSON protocol
- `PROGRESS/state.json`
- snapshot diff
- terminal audit
- worker fallback and recovery

This skill owns:

- extracting durable task requirements from user input and project files
- writing root-level `dualNN.md` files in the target project
- defining what work is allowed, forbidden, verifiable, blocked, and complete

Do not write runtime protocol schemas, `worker_report.json`, checkpoint rules, provider rules, or parser recovery rules into the brief.

## Input Compiler

Treat these as extraction inputs:

- user request
- rough requirement notes
- robustness, safety, or reliability notes
- bug reports
- failing command output
- handoff notes
- existing `STATUS.md` or context files
- directly related source files
- target project instructions

Convert extraction inputs into durable brief terms:

- terminal goal
- current batch
- current state
- allowed scope
- forbidden scope
- product contracts
- verification
- escalation rules
- completion criteria
- handoff state expectations

Do not preserve user wording unless it is required output text, a command, a path, an error message, or a contract term.

Do not make the brief depend on chat history, temporary files, deleted notes, source requirement files, or human memory. After the extraction input is moved or deleted, the brief must still contain enough information to continue.

## Preflight

Before writing a brief, inspect only what changes the brief:

- target project root
- applicable project instructions
- existing `dualNN.md` files
- `STATUS.md` or indexed context files if present
- files directly named by the user or needed to define scope and verification

Then decide:

- If the task is a small direct fix that does not benefit from planner-worker execution, tell the user `/g/app/dual` is overhead and offer a smaller direct handoff.
- If the task needs staged execution, recovery, verification review, or a worker batch, create a `dualNN.md` brief.
- If a missing fact would change scope, contracts, verification, or completion criteria, derive it from files first.
- If multiple valid choices remain, choose the smallest option that satisfies the stated goal and write the choice as a boundary or decision rule.

Do not ask the user for a choice when the worker can inspect, derive, acquire, or implement the smallest missing support within scope.

## File Output

Write brief files in the target project root.

Default file:

```text
dual00.md
```

Use numbered files only when separate entry files reduce prompt size or make batches reusable:

```text
dual00.md
dual10.md
dual20.md
```

Keep root `dualNN.md` files short. Put long durable context in project-owned files such as `STATUS.md` or `CONTEXT/*.md`, then reference them through `Context Index`.

All paths inside the brief are relative to the target project root.

## Brief Sections

Every entry brief must include these sections when applicable. Omit a section only when it would be empty and not useful to planner or worker execution.

```md
# task brief

## Goal

- terminal:
- current batch:

## Current State

- task authority:
- known progress:
- unresolved work:

## Progress

- [ ] P01:

## Context Index

- C01 `path`: read when ...

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
- restricted commands:
- expected evidence:

## Escalation Policy

- ...

## Completion Criteria

- terminal success:
- required evidence:
- not sufficient:

## Handoff State

- summary:
- changed files:
- tests:
- blocker:
- remaining autonomous actions:
- assumptions:
```

## Section Rules

`Goal`:

- `terminal` is the final user or product outcome.
- `current batch` is the next bounded worker phase.
- Do not make the terminal goal a partial fix, investigation step, or runtime status.

`Current State`:

- Name the task authority as extracted requirements, project files, or product contracts.
- Record known progress only if it affects the next plan.
- Record unresolved work as action-oriented remaining work.

`Progress`:

- Use stable `Pxx` ids.
- Mark only durable product progress, not runtime phase state.

`Context Index`:

- Include only project-owned files that the planner or worker may need later.
- Each item must say when to read the file.
- Do not list `PROGRESS/*`, runtime logs, protocol errors, `worker_report.json`, chat transcripts, or deleted source notes.

`Scope`:

- Allowed scope names files, directories, modules, commands, or behavior the worker may change.
- Forbidden scope names files, directories, behaviors, contracts, or commands the worker must not change.
- If a path is unknown, define a discovery boundary instead of inventing a path.

`Contracts`:

- Include only externally visible behavior, data shape, CLI/API behavior, file format, error behavior, invariants, or compatibility requirements.
- Do not include implementation preferences unless they protect a contract.

`Verification`:

- List commands the worker may run autonomously.
- Include expected evidence, not only command names.
- If a command is risky, unavailable, expensive, or forbidden by the project, put it under `restricted commands`.
- Do not require user approval for checks the worker can run within its available tools and project rules.

`Escalation Policy`:

- Require the planner to issue the next batch when completion criteria remain unmet.
- Allow `done` only when terminal goal and completion criteria are satisfied.
- Allow `failed` or `blocked` only after bounded in-scope attempts have evidence and no immediate autonomous action remains.
- Do not ask the user for clarification, approval, input, or a decision unless the remaining issue is outside workspace authority and cannot be derived.

`Completion Criteria`:

- Define terminal success in observable terms.
- List required evidence for each terminal condition.
- List conditions that are not sufficient by themselves, such as "tests passed but feature not wired" or "batch complete but inventory remains".

`Handoff State`:

- Define how worker reports should summarize changes for planner review.
- Use project-relative paths only.
- Put external blockers in `blocker`, not in `remaining autonomous actions`.

## Provenance Rules

Include:

- user task requirements
- target project instructions
- product contracts
- durable state from project files
- verification limits from the project

Exclude:

- global assistant rules
- current sandbox or approval policy
- temporary chat permissions
- runtime implementation details
- provider model details
- `/g/app/dual` debug artifacts
- source requirement files after extraction

Do not turn a temporary approval or environment limitation into a product task restriction.

## Runtime Artifact Rules

Never require the worker or planner to read, write, patch, validate, or preserve:

- `worker_report.json`
- `OUTPUT/worker_report.json`
- `PROGRESS/state.json`
- `PROGRESS/events.jsonl`
- `PROGRESS/run.log`
- `PROGRESS/runtime-status.md`
- `PROGRESS/protocol-errors.jsonl`

If recovery context matters, extract the product-relevant fact into `STATUS.md`, `CONTEXT/*.md`, or the brief.

## Quality Check

Before finishing, verify:

- the brief can be executed without chat history
- the terminal goal is broader than the current batch
- every allowed change has a boundary
- every forbidden change protects a real contract or risk
- verification contains expected evidence
- completion criteria cannot be satisfied by a partial batch alone
- no runtime protocol rule is duplicated as task content
- no source note is required reading after extraction
- paths are target-root-relative
- the text is short enough for a planner to scan every turn
