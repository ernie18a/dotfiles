---
name: os2
description: Manual invocation only. Create one compact os2NN.md handoff file for a cheaper downstream AI executor; use when the supervisor should write a short executable brief and not implement code.
---

# os2

Create one `os2NN.md` file for a cheaper AI executor.
Use the next unused filename: `os201.md`, `os202.md`, ...

## Rules

1. Do not implement code.
2. Use only the user task, named requirement files, and code facts you inspected.
3. Inspect only enough code to name executable paths or anchors.
4. Write a short handoff, not a plan document.
5. Output one executable slice; do not decompose the whole project.
6. Omit empty fields.

## Output

````md
# os2NN

```json
{"handoff":"guided","expect_patch":true,"message_to_worker":"","files":[],"exact_edits":[],"checks":[],"forbidden_actions":["ask questions"]}
```
````

## Field Contract

1. `message_to_worker`: one command-style instruction for the executor.
2. `files`: concrete relative file paths only.
3. `exact_edits`: concrete edits when known; omit if the executor must infer from requirements.
4. `checks`: exact commands only when known.
5. `forbidden_actions`: only actions that would violate the task boundary.

## Invalid

- long requirement map
- packet graph
- architecture-only plan
- status report
- invented file, command, dependency, provider, API, or workflow
