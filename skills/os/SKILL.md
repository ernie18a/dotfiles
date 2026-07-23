---
name: os
description: Manual invocation only
---

# os

Create one `osNN.md` handoff for multiple downstream code executors.
The handoff is for code implementation only. It is invalid if it is a status report, completion report, architecture-only plan, or requirement expansion outside the explicit requirement set.
Name handoffs incrementally as `os01.md`, `os02.md`, using the next unused `osNN.md`.

## Source Boundary

1. Treat explicit requirement files, user request, and inspected code facts as the only input set.
2. If a requirement list exists, it is the coverage boundary: every listed runtime behavior must map to one packet, integration contract, or local decision rule.
3. Do not delete, narrow, or defer a listed requirement because it is system-scale.
4. Do not add runtime behavior, product mode, provider, protocol, storage target, command, route, schema, or user workflow absent from the input set.
5. If an input value required for a contract is absent, write the bounded local decision rule or forbidden scope needed for execution from available inputs.
6. Make the handoff self-contained and predecessor-independent: inline every requirement, contract, decision, and source fact needed for execution; do not reference any prior `osNN.md` in any field, including `source`, or depend on prior conversation, external references, or unstated context. Deleting every prior `osNN.md` must not reduce the handoff's meaning, traceability, or executability.

## Before Writing

1. Before planning or writing the handoff, read and follow the current `deve` and `subt` skills in full.
2. Read the user request and governing instructions.
3. Read explicit requirement files named or implied by the request.
4. For code-affecting work, inspect code paths that can change runtime boundaries, shared contracts, write targets, state transitions, or dependency edges.
5. Use code facts to bind packets to existing paths when those paths already own the runtime behavior.
6. Stop inspecting when additional code facts no longer change packet ownership, dependency order, contracts, coverage trace, or invalid states.

## Planning Boundary

1. The agent invoking this skill owns requirement interpretation, code inspection, planning, packet boundaries, dependency decisions, and coverage decisions.
2. Resolve every decision supported by the input set before writing the handoff. Preserve absent required input as a bounded local decision rule or forbidden scope.
3. Downstream executors apply only the explicit code edits and contracts in their assigned packets; do not delegate requirement or skill interpretation, planning, ambiguity resolution, or coverage decisions to them.

## Split Rules

1. Define the first runtime path before packet assignment.
2. Split packets by I/O boundary, state ownership, runtime boundary, and touched paths.
3. Do not split by feature label, architecture layer, executor count, or module shape.
4. If one listed requirement spans multiple packets, add the shared contract and one integration packet.
5. If two packets share a schema, command, event, state file, route, or output path, assign one owner and make other packets depend on it.
6. If a packet depends on upstream behavior, declare the dependency order and owning packet.
7. If a code fact and requirement conflict, write the collision boundary as forbidden behavior or a local decision rule instead of choosing an unlisted behavior.

## Design Rules

1. Prefer local replacement boundaries: each packet must declare input contract, output contract, state owner, and failure contract.
2. Do not require a new module, abstraction, dependency, or file unless its absence prevents a listed requirement from having an owned path or contract.
3. Do not prohibit architecture, dependency, packet, or phase description when it is required to preserve listed requirement coverage, dependency order, or I/O boundary.
4. In the generated handoff, write contracts, decisions, and actions as exact paths, runtime conditions, and state changes; abstract labels alone are invalid.
5. Downstream executors may read and edit code and run syntax-only static checks. They must not execute or import project code.

## Dependency Types

- `P`: packet can run without undeclared dependencies.
- `I`: packet integrates outputs from two or more packets into the first runtime path.

## Packet Fields

1. executor role
2. requirement IDs
3. dependency type
4. allowed paths
5. forbidden paths
6. state owner
7. input contract
8. output contract
9. failure contract
10. action
11. coverage trace
12. invalid completion states

## Invalid Completion

Do not accept completion based on:
- requirement without packet, integration contract, or local decision rule
- packet fields filled only with abstract labels
- mock path replacing the first runtime path
- placeholder file or module
- TODO-only implementation
- enabled flag without runtime behavior
- state file without runtime effect
- generated code not called by runtime code
- shared contract changed without integration packet
- another packet's owned path changed without dependency update
- output artifact that cannot be traced to listed requirements
- any field references a prior `osNN.md`, or deleting prior handoffs reduces meaning, traceability, or executability

## Output Shape

```md
# osNN

## Requirement Map

- R1:
  - source:
  - requirement:
  - owner: P# | I# | Decision

## Goal

- requested behavior:
- first runtime path:
- execution boundary:
- executor model:

## Dependency Graph

- P1:
  - type: P | I
  - depends on:
  - owns:
  - exposes:

## Packets

### Packet P1: Name

- executor role:
- requirement IDs:
- type:
- depends on:
- action:
- allowed paths:
- forbidden paths:
- state owner:
- input contract:
- output contract:
- failure contract:
- coverage trace:
- invalid:

### Packet I1: Integration

- requirement IDs:
- action:
- allowed paths:
- input contract:
- output contract:
- coverage trace:
- invalid:

## Decisions

-

## Completion

- Reply exactly `DONE` only when every requirement ID is owned by a packet, integration contract, or local decision rule.
```
