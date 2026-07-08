---
name: os2
description: Manual invocation only. Create behavior-first implementation handoffs from user requests when Codex must avoid architecture-only plans, placeholder modules, mock success paths, and feature-inventory documents.
---

# os2

Create one implementation handoff for a downstream code executor. The handoff must convert the user request into the smallest real program change that can produce observable runtime behavior.

## Invariants

1. Use inspected code facts for code-affecting work. Do not base implementation scope on documents, summaries, or feature names when related code can be read.
2. Define the first usable runtime path before listing supporting work.
3. Treat a feature name as invalid unless the handoff defines the external behavior that proves the feature is active.
4. Mark unsupported or underspecified features as `planned`, not `implemented`.
5. Require real program evidence for each completed phase: command output, file change, state transition, network attempt, error path, or user-visible result.
6. Do not require new test scripts unless the user explicitly asks for tests.
7. Do not use mocks, fake success paths, placeholder modules, flag-only behavior, state-only behavior, or test-only behavior as completion evidence.
8. Stop adding scope when the next item would not change the first usable runtime path, a required contract, or a forbidden shortcut.

## Procedure

1. Extract the user-requested runtime behavior.
2. Inspect only code paths that can change the implementation boundary.
3. Define the minimal end-to-end path from input to observable result.
4. Define invalid states before implementation phases:
   - placeholder represents completion
   - enabled flag represents behavior
   - state file represents success without runtime effect
   - mock or synthetic local path replaces the real path
   - generated module has no called behavior
5. Split phases by the same runtime path, not by architecture layer or feature category.
6. For each phase, write:
   - action
   - real program evidence
   - invalid completion states
7. Omit architecture reports, module inventories, dependency wishlists, and broad roadmaps unless their removal changes execution.

## Output Shape

```md
# osNN

## Goal

- requested behavior:
- first usable path:
- execution boundary:

## Scope

Allowed:
- exact relative paths:
- behaviors:
- contracts:

Forbidden:
- exact relative paths:
- behaviors:
- invalid completion states:

## Phases

### Phase N: Name

Action:
- 

Evidence:
- 

Invalid:
- 

## Planned

- Include only features named by the user or governing input that cannot be implemented in the first usable path.

## Completion

- Reply exactly `DONE` when the requested code work is complete and the evidence listed above exists.
```

## Compression Rule

Delete any sentence that does not change one of these outputs: first usable path, allowed scope, forbidden scope, phase action, evidence, invalid completion state, or planned status.
