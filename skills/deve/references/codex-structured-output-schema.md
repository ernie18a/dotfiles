# Codex/OpenAI Structured Output Schema Requirements

When using OpenAI-compatible `response_format` with a JSON Schema (e.g. Codex `--output-schema`), all schemas must pass a strict structural validation. Violations produce `invalid_json_schema` errors with a `context` path pointing to the exact location.

## Constraint Chain

Errors appear one at a time — fixing one reveals the next. The chain (in order of typical encounter):

### 1. `kind` must have `type`

Every `kind` discriminator property must include both `type` and `const`:
```python
{"type": "string", "const": "batch_plan"}   # ✅
{"const": "batch_plan"}                      # ❌ — missing type
```

### 2. Every `type: object` must have `additionalProperties: false`

OpenAI requires **all** object schemas in the tree to explicitly set `additionalProperties: false`:
```python
{"type": "object", "additionalProperties": False, ...}  # ✅
{"type": "object", "additionalProperties": True, ...}    # ❌ — must be false
{"type": "object", ...}                                   # ❌ — missing key entirely
```

This applies recursively — nested objects inside `properties`, `items`, and `oneOf` branches.

### 3. `required` must include every property key

When `additionalProperties: false`, the `required` array must list **all** keys from `properties`:
```python
{"properties": {"a": ..., "b": ...}, "required": ["a", "b"]}  # ✅
{"properties": {"a": ..., "b": ...}, "required": ["a"]}         # ❌ — missing b
```

No property can be optional under structured output.

### 4. Every `type: array` must have `items`

Array schemas must define an `items` schema:
```python
{"type": "array", "items": {"type": "string"}}            # ✅
{"type": "array", "items": {"type": "object", ...}}       # ✅
{"type": "array"}                                          # ❌ — missing items
```

## Verification Pattern: Recursive Schema Walker

Use a recursive walker in tests to catch all violations in one pass:

```python
def _walk_object_schemas(schema: dict[str, Any], path: list[str]) -> list[str]:
    """Find all paths where type=object violates structured-output constraints."""
    issues: list[str] = []
    if not isinstance(schema, dict):
        return issues

    obj_type = schema.get("type")
    if obj_type == "object":
        if "additionalProperties" not in schema:
            issues.append(f"at {'/'.join(path)}: missing additionalProperties key")
        elif schema["additionalProperties"] is not False:
            issues.append(f"at {'/'.join(path)}: additionalProperties is {schema['additionalProperties']!r}, expected False")

        props = schema.get("properties", {})
        req = schema.get("required", [])
        missing_keys = [k for k in props if k not in req]
        if missing_keys:
            issues.append(f"at {'/'.join(path)}: required missing {missing_keys}")

    for key, val in schema.get("properties", {}).items():
        if isinstance(val, dict):
            issues.extend(_walk_object_schemas(val, path + [f"properties.{key}"]))
    items = schema.get("items")
    if isinstance(items, dict):
        issues.extend(_walk_object_schemas(items, path + ["items"]))
    for i, branch in enumerate(schema.get("oneOf", [])):
        if isinstance(branch, dict):
            issues.extend(_walk_object_schemas(branch, path + [f"oneOf[{i}]"]))
    return issues


@pytest.mark.parametrize("kind", ["batch_plan", "worker_report", "stop_decision", "audit_result"])
def test_json_schema_all_objects_have_additional_properties_false(kind: str) -> None:
    schema = _json_schema(kind)
    issues = _walk_object_schemas(schema, [kind])
    assert not issues, f"Schema {kind!r} has object schema issues:\n" + "\n".join(issues)
```

## When to Use This Pattern

Fix the schema generator (not the prompts) when:
- `invalid_json_schema` appears with `response_format`
- Error `context` points inside your generated schema tree
- The provider is OpenAI, Codex, or any platform using their structured output validation

Do NOT:
- Patch prompts to bypass schema validation
- Delete or rename provider schemas to mask the error
- Change the entry contract to work around schema issues
