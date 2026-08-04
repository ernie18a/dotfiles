---
name: os
description: Manual invocation only
---

# Purpose

- Create the next unused `osNN.md` as an implementation manual.
- The manual is not a report, architecture document, or rationale record.

# Author

- Read the user request, relevant code, and current `deve` skill.
- Apply these authoring rules directly; do not pass them to the executor.
- Use the requested outcome, explicit requirements, inspected facts, and technical judgment to resolve implementation decisions.
- Inspect relevant implementation evidence until further facts cannot materially change instructions or decisions.
- Preserve the requested behavior, scope, and meaning.
- After writing, do not check or validate the manual.

# Situational

- Classify by unresolved decision load, not file count or code volume.
- `Execution-dominant`: facts already determine the implementation.
- For execution-dominant work, write only the necessary actions and boundaries.
- `Decision-dominant`: plausible choices materially change important outcomes.
- For decision-dominant work, inspect relevant evidence, compare outcome-changing alternatives, and select every material choice before writing.
- Add detail only when its absence would force the executor to plan or guess.
- Express outcome-changing choices as exact instructions.
- Split only when work can proceed independently without repeated context.

# Manual

- Make the manual sufficient for implementation without independent planning.
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
- `By default, run only lightweight, non-behavioral static checks; run other validation only when the user explicitly requests it.`
- `After editing, reply exactly DONE with no report.`

# Completion

- Write the manual only after every requested behavior has an executable instruction.
- Reply exactly `DONE` after the `osNN.md` exists.
