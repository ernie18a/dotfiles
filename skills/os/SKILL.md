---
name: os
description: Manual invocation only
---

# Purpose

- Create the next unused `osNN.md` as an implementation manual.
- Transfer resolved decisions as instructions an executor can implement directly.
- The manual is not a report, architecture document, or rationale record.

# Author

- Read the user request, relevant code, and current `deve` skill.
- Apply these authoring rules directly; do not pass them to the executor.
- Use only explicit requirements and inspected code facts as authority.
- Inspect only until further facts cannot change instructions or decisions.
- Do not add, narrow, defer, or reinterpret requested behavior.
- After writing, do not check or validate the manual.

# Situational

- Classify by unresolved decision load, not file count or code volume.
- `Execution-dominant`: facts already determine the implementation.
- For execution-dominant work, write only the necessary actions and boundaries.
- `Decision-dominant`: plausible choices materially change important outcomes.
- For decision-dominant work, resolve every material choice before writing.
- Add detail only when its absence would force the executor to plan or guess.
- Do not leave choices whose alternatives could change the required outcome.
- Split only when work can proceed independently without repeated context.

# Manual

- Make the manual sufficient for implementation without independent planning.
- State the exact target paths, changes, order, boundaries, and final behavior.
- State critical contracts, state transitions, and failure behavior when relevant.
- Preserve existing ownership and interfaces unless the requirement changes them.
- Group related changes by touched function, ordered from broad to narrow.
- Prefer replacement, deletion, and consolidation before adding new structure.
- Omit alternatives, rationale, repetition, and facts that do not guide execution.
- Do not require packets, graphs, maps, or formal sections without practical value.
- Prevent redesign, scope expansion, shortcuts, speculative work, and embellishment.
- Never reference prior `osNN.md` files or unstated conversation context.

# Executor

- End every manual with the following executor directive.
- `Implement exactly as written; do not replan, redesign, simplify, or add behavior.`
- `Do not write tests or run project behavior.`
- `After editing Python code, run uv run python -m compileall -q <modified Python path(s)> as the sole minimum syntax validation; perform no other check, validation, verification, import, or project-code execution.`
- `After editing, reply exactly DONE with no report.`

# Completion

- Write the manual only after every requested behavior has an executable instruction.
- Reply exactly `DONE` after the `osNN.md` exists.
