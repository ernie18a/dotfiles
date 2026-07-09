---
name: os
description: Manual invocation only. Create one multi-executor code handoff from an explicit requirement set; preserve full requirement coverage while preventing behavior outside the requirement set.
---

# os

Create one `osNN.md` handoff for multiple downstream code executors.
The handoff is for code implementation only. It is invalid if it is a status report, completion report, architecture-only plan, or requirement expansion outside the explicit requirement set.

## Source Boundary

1. Treat explicit requirement files, user request, and inspected code facts as the only input set.
2. If a requirement list exists, it is the coverage boundary: every listed runtime behavior must map to one packet, integration contract, planned item, or blocked item.
3. Do not delete, narrow, or defer a listed requirement because it is system-scale.
4. Do not add runtime behavior, product mode, provider, protocol, storage target, command, route, schema, or user workflow absent from the input set.
5. If an input value required for a contract is absent, write `MISSING:<field>` and keep the owning packet blocked.

## Before Writing

1. Read the user request and governing instructions.
2. Read explicit requirement files named or implied by the request.
3. For code-affecting work, inspect code paths that can change runtime boundaries, shared contracts, write targets, state transitions, or dependency edges.
4. Use code facts to bind packets to existing paths when those paths already own the runtime behavior.
5. Stop inspecting when additional code facts no longer change packet ownership, dependency order, contracts, evidence, or invalid states.

## Split Rules

1. Define the first runtime path before packet assignment.
2. Split packets by I/O boundary, state ownership, runtime boundary, and touched paths.
3. Do not split by feature label, architecture layer, executor count, or module shape.
4. If one listed requirement spans multiple packets, add the shared contract and one integration packet.
5. If two packets share a schema, command, event, state file, route, or output path, assign one owner and make other packets depend on it.
6. If a packet depends on unimplemented upstream behavior, set `blocked by: P#`.
7. If a code fact and requirement conflict, write the collision as a blocked item instead of choosing an unlisted behavior.

## Design Rules

1. Prefer local replacement boundaries: each packet must declare input contract, output contract, state owner, and failure contract.
2. Do not require a new module, abstraction, dependency, or file unless its absence prevents a listed requirement from having an owned path or contract.
3. Do not prohibit architecture, dependency, packet, or phase description when it is required to preserve listed requirement coverage, dependency order, I/O boundary, or integration evidence.
4. Use skill `deve` for implementation packets: actions must be executable code edits with owned paths and runtime evidence.
5. Use skill `subt` for handoff text: remove any sentence whose deletion does not change coverage, dependency order, contract, evidence, or invalid completion states.

## Dependency Types

- `P`: packet can run without undeclared dependencies.
- `S`: packet is blocked by another packet or by `MISSING:<field>`.
- `I`: packet integrates outputs from two or more packets into the first runtime path.

## Packet Fields

1. executor role
2. requirement IDs
3. dependency type
4. blocked by
5. allowed paths
6. forbidden paths
7. state owner
8. input contract
9. output contract
10. failure contract
11. action
12. evidence
13. invalid completion states

## Invalid Completion

Do not accept completion based on:
- requirement without packet, integration contract, planned item, or blocked item
- mock path replacing the first runtime path
- placeholder file or module
- TODO-only implementation
- enabled flag without runtime behavior
- state file without runtime effect
- test-only behavior
- generated code not called by runtime code
- shared contract changed without integration packet
- another packet's owned path changed without dependency update
- output artifact that cannot be traced to listed requirements

## Output Shape

```md
# osNN

## Requirement Map

- R1:
  - source:
  - requirement:
  - owner: P# | I# | Planned | Blocked

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
- requirement IDs:
- type:
- blocked by:
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

- requirement IDs:
- action:
- allowed paths:
- input contract:
- output contract:
- evidence:
- invalid:

## Planned

-

## Blocked

-

## Completion

- Reply exactly `DONE` only when every requirement ID is owned and every non-blocked packet has evidence, with integration proving the first runtime path.
```
