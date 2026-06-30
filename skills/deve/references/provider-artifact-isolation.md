# Provider / CLI Tool Artifact Isolation

## Problem

External provider adapters (Codex CLI, subprocess-based LLM runners, etc.)
often write schema files, output JSON, and temp artifacts. A common default is
to write into the *target project's* directory (e.g. `root / "PROGRESS"` or
`root / ".codex"`). This causes two problems:

1. **Interruption orphan**: if a run is interrupted, the project root is left
   with provider temp files but no checkpoint `state.json` — making it
   unrecoverable.
2. **Repo contamination**: CI, git status, and downstream tooling picks up
   artifacts that have nothing to do with the project.

## Resolution Pattern — External Temp Directory

Insert a helper that resolves an **external** temp directory, preferring the
`TMPDIR` env var so the caller can control placement:

```python
import os
from pathlib import Path

def _provider_temp_dir(root: Path) -> Path:
    """Pick a repo-external temp dir for provider artifacts.

    Respects TMPDIR as long as it is NOT inside *root*.
    Falls back to a global system temp when unset or misconfigured.
    """
    tmpdir_env = os.environ.get("TMPDIR")
    if tmpdir_env:
        tmpdir = Path(tmpdir_env).resolve()
        root_resolved = root.resolve()
        try:
            tmpdir.relative_to(root_resolved)
        except ValueError:
            return tmpdir
    return Path("/g/.TMP/tmp")
```

Use it at the point of artifact creation:

```python
temp_dir = _provider_temp_dir(root)
temp_dir.mkdir(parents=True, exist_ok=True)
schema_path = temp_dir / f"codex-{expected_kind}-schema.json"
output_path = temp_dir / f"codex-{expected_kind}-output.json"
```

The provider CLI still runs with `-C <target_root>` (so it targets the right
project), but `--output-schema` and `-o` use **absolute paths** into the
external temp dir.

## Testing Pattern — Path Isolation Assertions

When testing provider artifact placement:

```python
def test_provider_uses_external_temp_dir(monkeypatch, tmp_path):
    project_root = tmp_path / "project"
    runtime_tmp = tmp_path / "runtime-tmp"
    monkeypatch.setenv("TMPDIR", str(runtime_tmp))

    # ... set up provider with root=project_root ...

    # Capture the subprocess command
    # Check --output-schema and -o flags:
    cmd = captured_cmd
    schema_path = Path(cmd[cmd.index("--output-schema") + 1])
    output_path = Path(cmd[cmd.index("-o") + 1])
    progress = project_root / "PROGRESS"

    assert not str(schema_path).startswith(str(progress))
    assert not str(output_path).startswith(str(progress))

    # After the run: PROGRESS/ must have zero provider files
    if progress.exists():
        assert not list(progress.glob("codex-*-schema.json"))
        assert not list(progress.glob("codex-*-output.json"))

    # Confirm TMPDIR was actually used
    assert str(schema_path).startswith(str(runtime_tmp))
```

## Key Constraints

- **Do NOT** move provider temp files into project subdirectories
  (`PROGRESS/provider/`, `TMP/`, `.hidden/`) — that still contaminates the
  project and fails the isolation goal.
- **Do NOT** clean up existing contamination from the same session — the fix
  only affects *future* writes.
- The `TMPDIR` check must reject values that point inside the project root
  (use `Path.relative_to` + `ValueError` catch).
