---
name: dual
description: "Prepare INPUT/*.md briefs for the /g/app/dual dual-session Codex orchestrator. Use when Codex should turn a user goal, repo state, unresolved issue, or handoff notes into low-coupling input files that let a smart Codex guide a worker Codex with structured progress, supervision, escalation rules, verification boundaries, and minimal manual switching."
---

# Dual

## Purpose

Create input documents for `/g/app/dual`.

The tool is the runtime:

- start smart and worker Codex sessions
- pass prompts between them
- require structured replies
- persist state and transcript
- apply generic runtime guardrails

This skill is the strategy layer:

- write `INPUT/*.md`
- define task goal, scope, validation, stop rules, and escalation policy
- keep task semantics out of the tool
- make smart Codex lead worker Codex without requiring the user to manually switch models

## Output

Create one or more markdown files intended to be placed under a target project's `INPUT/`.

Default:

```text
INPUT/00-brief.md
```

Use multiple files only when it improves sorting and reuse:

```text
INPUT/00-brief.md
INPUT/10-context.md
INPUT/20-policy.md
```

Prefer one short `INPUT/00-brief.md` with an explicit context index. Put long source material, architecture notes, transcripts, logs, and reference docs outside `INPUT/` unless Smart must receive them on every review.

Do not create tool-specific code unless the user explicitly asks to modify `/g/app/dual`.

## Source Handling

Accept the user's named source material as the root of truth for the generated brief. The source may be an existing handoff file, project note, issue, repo state summary, chat instruction, or a combination of these.

Convert source material into the `INPUT/*.md` contract instead of assuming the source already has that shape. Preserve source path semantics: if the root material says to read `STATUS.md`, keep it as `STATUS.md` unless it explicitly names `INPUT/STATUS.md`.

When source material contains a local workflow such as "read this first, then read that only if needed", translate it into scope and context rules for Smart/Worker. Do not flatten it into an instruction to read every referenced file up front.

Separate terminal goals from current next actions. A source file's `Next`, current issue, or handoff focus is the next batch unless the source explicitly defines it as final completion. Use status files, checklists, acceptance criteria, or user goals to derive terminal completion criteria. If terminal completion cannot be inferred, state that gap in the brief instead of treating the current next action as complete success.

## Context Indexing

Keep `INPUT/*.md` as a routing and contract surface. `/g/app/dual` concatenates every `INPUT/*.md` file into Smart's goal, so an index only saves tokens when the long material lives outside `INPUT/`.

When the task has more context than Smart needs every turn:

- Add a compact `Context Index` in `INPUT/00-brief.md`.
- Reference non-`INPUT` context files such as `CONTEXT/*.md`, `STATUS.md`, `DESIGN.md`, or existing project docs.
- Give each context item a stable id such as `C01`, `C02`, or `P01`.
- State when Smart or Worker should read each item.
- Track progress with checkboxes only for durable task state, not for every thought.

Example:

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

## Fit Check

Before writing input files, verify the premise:

- The goal needs smart planning plus cheaper worker execution.
- The task can be described with clear scope and stop conditions.
- Worker can make progress from a batch plan without reading chat history.
- Any required repo context can be named directly.
- Terminal completion criteria can be identified, or the brief can explicitly mark them as unresolved scope.

If the task is a direct one-shot fix, say that `/g/app/dual` may add overhead and produce a smaller direct handoff instead.

## File Requirements

Each generated input set must be self-contained enough for smart Codex to start.

Include:

- terminal goal and current batch goal when they differ
- current state or known issue
- compact progress checklist for durable phase state
- context index for optional large references
- allowed scope
- forbidden scope
- contracts that must not change
- verification commands or verification limits
- escalation policy
- completion criteria
- reporting expectations

Avoid:

- chat history dumps
- long architecture essays
- long logs or copied command output
- long source files or diffs
- tool implementation details
- duplicate runtime rules already owned by `/g/app/dual`
- instructions that require the tool to understand project-specific semantics

## Boundary Rules

Put in the input documents:

- task slicing
- how smart should continue after a current batch succeeds while terminal criteria remain unmet
- issue equivalence rules
- when worker may retry
- when smart must shrink scope
- when smart must stop retrying the same worker path and choose block, clarify, or a different smaller batch
- when human input is required
- project-specific command restrictions

Do not put in the input documents as requirements on the tool:

- state file format
- transcript file format
- JSON parser behavior
- turn counter behavior
- runtime exception retry policy
- MCP protocol handling

Mention tool behavior only as an assumption when needed.

## Smart Review Discipline

Smart review should be grounded in concrete current state, not a fresh abstract plan from the terminal goal.

When reviewing a worker result, tell Smart to base the next decision on:

- worker report
- changed files
- verification output
- unresolved blocker
- completion criteria

Smart should use that evidence to approve completion, shrink scope, clarify the next batch, change approach, or block. Do not frame escalation as Smart taking over implementation unless the user explicitly wants Smart-side edits outside the normal Worker path.

## Thread And State Assumptions

`/g/app/dual` uses separate Smart and Worker Codex threads and stores their thread ids in `PROGRESS/state.json`.

Write briefs with these assumptions:

- Continuing the same state usually continues the same Smart/Worker threads.
- `Ctrl+C` interrupts the local run; it is not a context compression mechanism.
- For long work, represent fresh phases with a short updated brief instead of an accumulated transcript.
- Do not ask Smart or Worker to manage thread ids, state files, or transcript files unless the user explicitly asks to modify `/g/app/dual`.

When a phase is complete, summarize durable facts into `INPUT/00-brief.md` and move stale detail outside `INPUT/`.

## Minimal Template

Use this shape unless the user provides a stronger format:

```md
# dual input

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

- If worker reports `done`, smart reviews concrete current state and Completion Criteria before deciding whether to issue the next batch or stop.
- Smart should use the Context Index to pick only the files needed for the next batch.
- Smart may return `done` only when Completion Criteria are met.
- If the current batch is complete but Completion Criteria are not met, smart must issue the next batch from the remaining source-of-truth work.
- If worker reports `blocked` on a local implementation issue, smart should first shrink or clarify the batch.
- If the same worker path remains blocked after one revised batch, smart should choose a different smaller batch, return `blocked`, or ask for human input. It should not take over implementation by default.
- If the next action would violate Scope, Contracts, or command restrictions, smart should return a `blocked` stop decision.
- Runtime failures, malformed JSON, or tool protocol failures are owned by `/g/app/dual`, not by this policy.

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

## Escalation Guidance

Keep escalation semantic and task-local.

Good:

```text
Treat the issue as the same issue only when the failing command, failing behavior, and touched module are unchanged.
```

Bad:

```text
The tool should count three worker failures and then force smart to code.
```

The tool cannot reliably know whether two implementation failures are the same task issue. Smart Codex can judge that from the worker report and repo context.

## Cross-Project Use

Assume `/g/app/dual` is run from the target project directory:

```bash
uv run --project /g/app/dual --directory "$PWD" python -m dual
```

## Path Semantics

Generated input files live under `INPUT/`, but project paths mentioned inside them are relative to the target project root, not to `INPUT/` and not to `/g/app/dual`.

Use `INPUT/...` only for files that are themselves task inputs. Use root-relative paths such as `STATUS.md`, `src/foo.rs`, or `tests/foo.rs` for project context and implementation files.

If a referenced project file may not exist, keep that as an uncertainty in the brief instead of rewriting the path.

## Quality Bar

Prefer the smallest useful input set.

Remove anything that does not affect:

- smart planning
- worker execution
- validation
- stopping
- escalation

When in doubt, write less and make boundaries sharper.
