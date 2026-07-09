---
name: os2
description: Manual invocation only. Create one behavior-first implementation handoff from a user request; use when Codex must define the first runtime path, completion evidence, planned items, and invalid completion states for a downstream code executor.
---

# os2

Create one `osNN.md` handoff for one downstream code executor.

## Decision Rules

1. If related code exists, inspect code paths that can change the implementation boundary.
2. If a requested feature has no external behavior, mark it `planned`.
3. If a feature is unsupported or underspecified, mark it `planned`.
4. If work does not change the first runtime path, a required contract, or an invalid completion state, omit it.
5. Do not require new test scripts unless the user requests tests.

## Required Fields

1. requested behavior
2. first runtime path
3. execution boundary
4. allowed paths, behaviors, contracts
5. forbidden paths, behaviors, invalid completion states
6. phase actions
7. phase evidence
8. planned items

## Invalid Completion

Do not accept completion evidence based on:
- mock path replacing the real path
- placeholder file or module
- enabled flag without behavior
- state file without runtime effect
- test-only behavior
- generated code not called by runtime code

## Output Shape

```md
# osNN

## Goal

- requested behavior:
- first runtime path:
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

-

## Completion

- Reply exactly `DONE` when the requested code work is complete and the listed evidence exists.
```
