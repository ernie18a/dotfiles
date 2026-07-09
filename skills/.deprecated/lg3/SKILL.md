---
name: lg3
description: Manual invocation only
---

# lg3

## Purpose

Create one entry manual for `bin/lg3 <entry.md>`.

The skill does not run `bin/lg3`, does not create `.lg3/`, and does not modify `a.md`, `r.md`, or `config.toml`.

## Required Rules

Apply this priority order:

1. `a.md`
2. `r.md`
3. User request

If a required value is absent from the user request or local project facts, write `MISSING:<field>` instead of inventing it.

Use relative paths only.

## Entry Manual

Output one markdown document with these fields:

```md
# execution manual

goal:

allowed paths:

forbidden paths:

command:

log path:

checkpoint:
```

Field rules:

- `goal`: preserve the user-requested outcome.
- `allowed paths`: include only explicit or locally verified paths the worker may edit.
- `forbidden paths`: include `a.md`, `r.md`, `AGENTS.md`, `config.toml`, `.lg3/`, and any user-forbidden paths.
- `command`: include the command only when the user specified it or the project has one unambiguous local command.
- `log path`: use `.lg3/runs/<run_id>/current.log` unless the user gave another relative path.
- `checkpoint`: one short instruction for the worker to write `cheap:` state after execution.

## Boundaries

Do not:

- split the request into multiple task files;
- create `tasks/current.md`;
- create or edit `.lg3/` run state;
- choose provider, model, or effort;
- run commands;
- diagnose errors;
- add product behavior not present in the request.

## Output

Return only the entry manual content unless the user asks for a filename or explanation.
