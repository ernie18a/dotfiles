---
name: os
description: Manual invocation only
---

# Purpose

- Create the next unused `osNN.md` as an implementation manual.

# Author

- Read the user request, relevant code, and current `deve` skill.
- Apply these authoring rules directly.
- Resolve implementation decisions using explicit requirements, inspected facts, and technical judgment while preserving the requested outcome, behavior, scope, and meaning.
- Inspect relevant implementation evidence until further facts cannot materially change instructions or decisions.
- After writing, do not check or validate the manual.

# Situational

- Classify work by unresolved decision load.
- `Execution-dominant`: facts already determine the implementation; write only the necessary actions and boundaries.
- `Decision-dominant`: plausible choices materially change important outcomes; inspect relevant evidence, compare outcome-changing alternatives, and select every material choice before writing.
- Split only when work can proceed independently without repeated context.

# Manual

- Record every material implementation decision as an exact instruction, with only the detail required to prevent the executor from planning, guessing, or making outcome-changing decisions.
- State critical contracts, state transitions, and failure behavior when relevant.
- Prefer replacement, deletion, and consolidation before adding new structure.
- Include only implementation instructions and facts that guide execution.

# Executor

- End every manual with the following executor directive.
- `Implement exactly as written.`
- `Unless the user explicitly requests otherwise, run only lightweight, non-behavioral static checks.`
- `After editing, reply exactly DONE.`

# Completion

- Reply exactly `DONE` after the `osNN.md` exists.
