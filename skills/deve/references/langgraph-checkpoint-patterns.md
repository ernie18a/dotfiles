# LangGraph Checkpoint / Persist Placement

## Unconditional Persist Before First Provider Call

The first provider call (`planner.plan()`, `worker.work()`) can raise or get interrupted.
If no `state.json` was written before that call, the session has zero durable state and
cannot resume with minimal tokens (violates `r2.md` requirement).

**Rule**: persist unconditionally between `load_checkpoint` and the conditional router,
**not** on the conditional router itself.

### Correct (os04 fix)

```
START → load_checkpoint → persist_after_load → conditional_route → plan_batch
                                                          → verify_evidence
                                                          → persist_checkpoint
```

```python
builder.add_edge(START, "load_checkpoint")
builder.add_edge("load_checkpoint", "persist_after_load")
builder.add_conditional_edges(
    "persist_after_load",
    _route_after_load,
    {"plan": "plan_batch", "verify": "verify_evidence", ...},
)
```

### Wrong — persist after conditional

`load_checkpoint → conditional → (plan → persist / verify → persist ...)`

If `plan_batch` calls `planner.plan()` which raises, the `persist_after_plan` node
never runs. No `state.json` exists. Interruption = total loss.

### Wrong — persist inside conditional, before provider

Only works if **every** route calls persist first. Easy to miss when adding a new route.

## Implementation Pattern

Reuse an existing `_persist_intermediate` node:

```python
builder.add_node("persist_after_load", _persist_intermediate)
```

`_persist_intermediate` calls `save_state(runtime, Path(runtime.state_path))` and
returns `{}` (no state mutation, pure side-effect node).

The conditional router function stays on the same `next_route` key — just move the
`add_conditional_edges` call to the new persist node.

## Pitfall: Reuse Route

When `_route_after_load` returns `"reuse"`, the old code routed directly to
`persist_checkpoint`. After `persist_after_load`, the route is:

```
persist_after_load → persist_checkpoint → END
```

This is fine — `persist_after_load` already saved the initial state, and
`persist_checkpoint` saves the terminal receipt. Double-write is idempotent
(atomic replace via `.tmp` + `.replace()`).
