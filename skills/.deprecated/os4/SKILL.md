---
name: os4
description: Manual invocation only. Convert one or more stated requirements into requirement IDs, collision boundaries when needed, implementation packets, dependency order, blocked items, and runtime evidence; use when Codex must preserve all stated requirements while deciding whether work is single-packet, sequential, integration, or parallel.
---

# os4

Create one `osNN.md` execution manual from one request or a multi-requirement specification.

## Required Outputs

1. Requirement ledger: one stable `R#` for each stated requirement.
2. Collision map: required only when two or more requirements or packets may share paths, functions, state, schemas, routes, commands, APIs, UI surfaces, migrations, or external integrations.
3. Execution packets: grouped requirements with ownership, contracts, dependencies, and evidence.
4. Integration section: required only when two or more packets join into one runtime path.
5. Blocked or planned table: every stated requirement not assigned to an implementable packet.

## Decision Rules

1. If a requirement has no observable runtime behavior, mark it `blocked` with `MISSING:observable_behavior`.
2. If a requirement lacks input, output, or failure behavior, write `MISSING:<field>`.
3. If related code exists, inspect runtime code before packet assignment.
4. If the request has one implementable requirement and no shared boundary, create one `sequential` packet and omit collision rows unrelated to that packet.
5. If requirements touch the same function, route, command, schema, state file, shared store, migration, public API, or UI surface, group them in one packet or mark the later packet `sequential`.
6. If requirements have disjoint allowed paths and disjoint runtime boundaries, they may be separate `parallel` packets.
7. If a packet consumes another packet's contract, mark it `sequential` and set `blocked by: P#`.
8. If packet outputs must be wired together, create one `integration` packet.
9. If a requirement cannot be implemented from the specification and inspected code facts, mark it `blocked`.
10. If a stated requirement is outside the first runtime path, mark it `planned`.
11. If a sentence does not change requirement coverage, packet ownership, dependency order, runtime contract, evidence, invalid state, or blocked/planned status, delete it.

## Parallel Test

Mark a packet `parallel` only if all conditions are true:

1. `allowed paths` is exact.
2. `allowed paths` does not overlap another parallel packet, or ownership is limited to named functions, classes, sections, routes, or commands.
3. The packet does not redefine a contract consumed by another packet.
4. The packet does not write shared state without a named owner.
5. The packet has evidence that can be produced without completing an undeclared dependency.

Else mark it `sequential`, `integration`, or `blocked`.

## Invalid Completion

Do not accept completion evidence based on:

- mock path replacing the real path
- placeholder file or module
- TODO-only implementation
- enabled flag without behavior
- state-only behavior without runtime effect
- test-only behavior
- generated code not called by runtime code
- parallel claim without passing the Parallel Test

## Output Shape

```md
# osNN

## Goal

- spec source:
- first runtime path:
- execution boundary:
- executor model:

## Requirement Ledger

| ID | Behavior | Input | Output | Failure | Status |
|---|---|---|---|---|---|
| R1 |  |  |  |  | implement |

## Collision Map

| Boundary | Owner Packet | Shared With | Rule |
|---|---|---|---|
|  |  |  |  |

## Execution Packets

### Packet P1: Name

- mode: parallel | sequential | integration | blocked
- covers:
- blocked by:
- runtime boundary:
- allowed paths:
- forbidden paths:
- input contract:
- output contract:
- failure contract:
- action:
- evidence:
- invalid:

## Integration

- packets joined:
- contract checked:
- first runtime path evidence:
- invalid:

## Blocked or Planned

| Requirement | Status | Missing field or reason |
|---|---|---|
| R# | blocked | MISSING:<field> |

## Completion

- Reply exactly `DONE` only when every `implement` requirement has packet evidence and integration proves the first runtime path.
```
