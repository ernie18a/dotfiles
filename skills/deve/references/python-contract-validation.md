# Sentinel-based list-field validation for dict-to-dataclass conversion

When converting a raw dict payload into a frozen dataclass, list fields have three states:
- **Missing** (key absent) → use default empty `()`
- **Present with `null`** → must raise `ValueError` (protocol violation, not `TypeError`)
- **Present with a non-list type** (string, int) → must raise `ValueError` (protocol violation)

## Problem

Naive code like `payload.get("field", ())` crashes with `TypeError` when the field is explicitly `null`,
because `tuple(str(item) for item in None)` is not iterable. The crash type is wrong — it should be
a controlled `ValueError` so the caller can route it to protocol logging, not a raw Python traceback.

## Solution: sentinel pattern

```python
_MISSING = object()

def _require_list_field(payload: dict, field_name: str, contract_name: str) -> list:
    value = payload.get(field_name, _MISSING)
    if value is _MISSING:
        return []                          # absent → default empty
    if value is None:
        raise ValueError(
            f"invalid {contract_name} payload: field '{field_name}' must be a list, got null"
        )
    if not isinstance(value, (list, tuple)):
        raise ValueError(
            f"invalid {contract_name} payload: field '{field_name}' must be a list, "
            f"got {type(value).__name__}"
        )
    return list(value)
```

The sentinel (`_MISSING = object()`) is essential because `payload.get("x", ())` cannot distinguish
`{"x": None}` from `{}` — both return `()` with a tuple default. The sentinel lets you tell them apart.

## Usage in `worker_report_from_payload`

```python
def worker_report_from_payload(payload: dict) -> WorkerReport:
    changed_files_raw = _require_list_field(payload, "changed_files", "worker_report")
    tests_raw = _require_list_field(payload, "tests", "worker_report")
    evidence_raw = _require_list_field(payload, "evidence", "worker_report")
    remaining_raw = _require_list_field(payload, "remaining_autonomous_actions", "worker_report")
    return WorkerReport(
        changed_files=tuple(str(item) for item in changed_files_raw),
        tests=tuple(test_result_from_payload(item) for item in tests_raw),
        evidence=tuple(str(item) for item in evidence_raw),
        remaining_autonomous_actions=tuple(str(item) for item in remaining_raw),
        ...
    )
```

## Why not use `isinstance` on the payload value alone?

`isinstance(None, list)` is `False`, so `isinstance(value, (list, tuple))` already rejects null.
But the `None` case deserves a distinct error message ("got null") vs the general non-list message.
The sentinel also keeps the three-way branching explicit rather than conflating absent/null in one path.

## Related

- See `contracts.py` in the dual project for a full implementation with `_require` (scalar required fields).
- The `blocker` field is scalar optional — `null` is valid there because it's not a list. Do not apply `_require_list_field` to scalar fields.
