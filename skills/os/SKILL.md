---
name: os
description: Manual invocation only
---

# Purpose

- Create one implementation handoff named with the next unused `osNN.md`.
- The handoff may serve one or more downstream code executors.
- Do not produce a status report, completion report, or architecture-only plan.

# Situational

- Classify work by unresolved decision load, not task size or code volume.
- `Execution-dominant`: inspected facts already determine behavior and contracts.
- Keep execution-dominant work in one end-to-end packet with minimal planning.
- `Decision-dominant`: plausible choices materially change important boundaries.
- Resolve decision-dominant choices before assigning implementation packets.
- `Mixed`: resolve critical choices, then merge the remaining execution work.
- Do not split when handoff and repeated-understanding cost exceeds gained independence.

# Sources

- Use only the user request, explicit requirement files, and inspected code facts.
- A requirement list defines the complete coverage boundary.
- Do not delete, narrow, defer, or expand requirements.
- Do not add behavior, interfaces, dependencies, or workflows absent from sources.
- Do not derive product constraints from the handoff generation environment.
- Encode missing contract inputs as bounded local decisions or forbidden scope.

# Preparation

- Read and follow the current `deve` and `subt` skills in full.
- Read the user request, governing instructions, and explicit requirement files.
- Inspect code that owns runtime paths, I/O, state, writes, or dependencies.
- Stop inspection when more facts cannot change ownership or contracts.

# Decisions

- The current agent owns interpretation, inspection, planning, and coverage.
- Resolve choices that would change contracts, state, runtime, or dependencies.
- Do not delegate requirement interpretation or material ambiguity.
- Let executors choose details only when declared boundaries remain unchanged.
- Record requirement and code collisions as forbidden behavior or local decisions.

# Packets

- Define the first runtime path before assigning packets.
- Use the fewest packets that preserve independent ownership.
- Split only by I/O, state ownership, runtime boundary, or touched paths.
- Do not split by feature name, architecture layer, module shape, or executor count.
- Give every shared schema, command, event, state, route, or output one owner.
- Declare dependencies whenever a packet consumes another packet's behavior.
- Add one integration packet when a requirement or contract spans packets.
- `P` packets run without undeclared dependencies.
- `I` packets integrate multiple packet outputs into the first runtime path.

# Contracts

- Bind actions and contracts to exact paths, runtime conditions, and state changes.
- Each packet declares inputs, outputs, state ownership, and failure behavior.
- Prefer local replacement boundaries over new architecture.
- Add no module, abstraction, dependency, or file unless coverage requires it.
- Bind existing behavior to its current owning path whenever possible.

# Executor

- Executors may read and edit only their allowed code paths.
- Executors may run syntax-only static checks.
- Executors must not execute or import project code.
- Executors must not change another packet's contract or owned path.

# Handoff

- Make the handoff self-contained and independent of prior `osNN.md` files.
- Inline every requirement, decision, code fact, and contract needed to execute.
- Do not rely on conversation, external references, or unstated context.
- Include `Requirement Map`, `Goal`, `Dependency Graph`, `Packets`, and `Decisions`.
- Map every requirement to one packet, integration contract, or local decision.
- State the requested behavior, first runtime path, and execution boundary.
- State each packet's owner, type, dependencies, owned paths, and exposed contract.
- State allowed paths, forbidden paths, action, contracts, coverage, and invalid states.

# Invalid

- A requirement has no packet, integration contract, or local decision.
- An executor must make a choice that changes a declared boundary.
- A packet contains abstract labels instead of executable facts.
- A mock, placeholder, TODO, flag, or inert state replaces runtime behavior.
- Generated code is not reached from the first runtime path.
- A shared contract changes without an integration packet.
- An owned path changes without its owner or dependency update.
- An output cannot be traced to an explicit requirement.
- Removing prior handoffs reduces meaning, traceability, or executability.

# Completion

- Write the handoff only after every requirement has an owner and coverage trace.
- Reply exactly `DONE` after the valid `osNN.md` handoff exists.
