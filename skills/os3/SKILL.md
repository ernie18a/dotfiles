---
name: os3
description: Manual invocation only. Create one multi-executor implementation handoff from a large code request; use when Codex must split work into packets with owned paths, contracts, dependency types, integration evidence, and invalid completion states.
---

# os3

Create one `osNN.md` handoff for multiple downstream code executors.

## Decision Rules

1. If related code exists, inspect paths that can change runtime boundaries, shared contracts, write targets, or dependency edges.
2. Define the first runtime path before packet assignment.
3. Split packets by runtime boundary, I/O contract, state ownership, and touched paths.
4. Do not split by architecture layer, feature category, or executor count.
5. If packets share a contract, state transition, schema, route, command, event, or file ownership, add dependency or integration ownership.
6. If a packet depends on an unimplemented upstream behavior, set `blocked by: P#`.
7. If two or more packets must join into one runtime path, add one integration packet.
8. If work does not change packet ownership, dependency order, contract, evidence, invalid state, or planned status, omit it.

## Dependency Types

- `P`: packet can run without undeclared dependencies
- `S`: packet is blocked by another packet
- `I`: packet integrates outputs from two or more packets

## Packet Fields

1. executor role
2. allowed paths
3. forbidden paths
4. state owner
5. input contract
6. output contract
7. failure contract
8. action
9. evidence
10. invalid completion states

## Invalid Completion

Do not accept completion evidence based on:
- mock path replacing the real path
- placeholder file or module
- TODO-only implementation
- enabled flag without behavior
- state file without runtime effect
- test-only behavior
- generated code not called by runtime code
- shared contract changed without integration packet
- another packet's owned path changed without dependency update

## Output Shape

```md
# osNN

## Goal

- requested behavior:
- first runtime path:
- execution boundary:
- executor model:

## Dependency Graph

- P1:
  - type: P | S | I
  - blocked by:
  - owns:
  - exposes:

## Packets

### Packet P1: Name

- executor role:
- action:
- allowed paths:
- forbidden paths:
- state owner:
- input contract:
- output contract:
- failure contract:
- evidence:
- invalid:

### Packet I1: Integration

- action:
- evidence:
- invalid:

## Planned

-

## Completion

- Reply exactly `DONE` only when all packets have evidence and integration proves the first runtime path.
```
