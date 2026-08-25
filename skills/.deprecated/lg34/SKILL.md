---
name: lg34
description: Create or repair entry/index contracts for LG3 and LG4 Deep Agents wrapper runtimes. Use when Codex needs to convert user requirements into an LG3/LG4-compatible entry markdown file, choose between LG3 and LG4 entry shape, tighten Deep Agents audit boundaries, or repair a blocked/failed LG3/LG4 run without executing the runtime.
---

# LG34

## Role

Compile user intent into a compact LG3/LG4 entry/index contract. Create a new entry by default, named incrementally for the selected runtime (`lg3NN.md` or `lg4NN.md`). Edit an existing entry only when the user identifies it or asks for repair.

## Decision Order

1. Classify the request: new entry, entry edit, runtime repair, or design discussion.
2. Select LG3 or LG4 from the user request, entry path, wrapper command, project directory, or existing entry.
3. Inspect local instructions, README, parser, runtime, tests, wrapper, or directly related code only when they can change the entry contract.
4. Identify the smallest high-value failure boundaries before writing fields.
5. Keep only facts that can change scope, evidence, verification, completion criteria, stop conditions, or index references.
6. Compile the smallest auditable entry. Encode unresolved risk as a boundary or `Stop`.

## Authority Boundary

The skill defines only runtime input:

- target runtime
- goal, scope, evidence, verification, completion criteria, and stop conditions
- minimal index references when one entry would grow too large

The runtime decides:

- progress state under `LG3_PROGRESS/` or `LG4_PROGRESS/`
- worker/backend execution
- verification result
- audit acceptance and audit reason
- cached receipt reuse or rejection
- terminal success

Never make model self-report, chat history, status prose, progress logs, stdout alone, or cached receipts sufficient for terminal success.

## Runtime Choice

Use LG3 when the entry needs a concrete runtime-executed `Action`. Use LG4 when the work should be expressed as a Deep Agents wrapper task whose terminal gate is verification plus audit acceptance.

If the choice changes behavior and cannot be inferred from the workspace, write the uncertainty into `Stop` or ask for the target runtime.

## Entry Shape

Use the shared LG3/LG4 contract unless the local parser or README says otherwise:

````md
# LG3 Entry

## Goal
...

## Scope
...

## Evidence
...

## Action
```bash
...
```

## Verification
```bash
...
```

## Completion Criteria
...

## Stop
...
````

Required sections:

- `Goal`
- `Scope` or `Boundaries`
- `Evidence`
- `Verification`
- `Completion Criteria` or `Completion`
- `Stop`

`Action` is only for runtimes that execute it. Current LG3 does; current LG4 wrapper entries should express expected work through `Goal`, `Scope`, `Evidence`, and `Verification`.

## Field Rules

`Goal`: one terminal objective; add the current smallest objective only when it changes the next run.

`Scope`: allowed reads, writes, commands, evidence sources, and forbidden boundaries.

`Evidence`: observable workspace changes, file contents, command output, terminal receipt facts, or explicit user input. Tie evidence to the target root when stale receipt or wrong-workspace success is possible.

`Action`: the next smallest executable workspace command when the selected runtime supports it. Keep destructive, production-facing, long-running, costly, or real-service actions out of the entry unless permission is explicit.

`Verification`: at least one explicit command. Put the decisive command first for LG4 because the current parser executes the first non-empty command. If no deterministic check is known, make that a `Stop` blocker.

`Completion Criteria`: verification success plus required evidence plus audit acceptance. Include insufficiency rules only when false success is likely.

`Stop`: concrete blockers such as missing runtime choice, ambiguous scope, missing permission, parser mismatch, unsafe writes, unverifiable evidence, or unavailable external authority.

High-value failure boundaries:

- partial work counted as terminal success
- wrong files or contracts changed
- verification passes while requested behavior remains unwired
- stale, cached, mocked, or pre-existing evidence counted as fresh success
- external blocker hidden as done or expanded into unrelated work

## Index Rules

Use index references only when they reduce repeated reading or editing. Reference stable project-owned docs by path and purpose; keep the next executable decision in the entry. The entry should not become a copied log, raw chat archive, source dump, or receipt archive.

## Repair Rules

For blocked, failed, rejected, malformed, or no-progress feedback:

- Add missing required sections.
- Replace weak verification with a concrete command or a `Stop` blocker.
- Tighten scope when the worker acted too broadly.
- Require fresh evidence when cache, digest, target root, verification, or audit reason may be stale.
- Move behavior out of `Action` when the selected runtime does not execute it.
- Preserve strict completion criteria; repair ambiguity without lowering the audit bar.

## Output

Report the target runtime, entry path, changed constraints, remaining blockers, and next command when useful.

Prefer concise Traditional Chinese in replies unless the artifact is already in another language.
