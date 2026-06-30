# Markdown Verification Section Parsing

When a runtime reads a markdown entry's `## Verification` section and parses it into
executable commands vs audit rules, several pitfalls arise from mixing prose and code.

## Entry Verification Section Structure (lg01.md style)

```markdown
## Verification
- Required commands:
  - `CARGO_HOME=$PWD/TMP/.cargo-home CARGO_TARGET_DIR=$PWD/TMP/target cargo test`
  - `CARGO_HOME=$PWD/TMP/.cargo-home CARGO_TARGET_DIR=$PWD/TMP/target cargo run -- scan`
- The second command may require user-provided `INPUT/`; if `INPUT/` is absent...
- Verification must be offline...
```

After `_clean_section_text()` (which strips list markers):
```
Required commands:
`CARGO_HOME=... cargo test`
`CARGO_HOME=... cargo run -- scan`
The second command may require user-provided `INPUT/`; if `INPUT/` is absent...
Verification must be offline...
```

## Parsing: `_iter_list_items` + `_parse_verification`

Items are split by line, and each goes through a series of guards:

### Guard 1: Strip Outer Backticks

If an item is wrapped in backticks (e.g. `` `command` ``), strip them first:
```python
text = item.strip()
if text.startswith("`") and text.endswith("`"):
    text = text[1:-1].strip()
```

### Guard 2: Inline Backtick Detection (Prose)

If the item contains backticks *inside* (not just surrounding), it's prose
referencing file paths or terms:
```python
if "`" in text:
    # prose with inline code references → audit rule
```

Examples: `see \`INPUT/\` directory`, \`if \`INPUT/\` is absent\`

### Guard 3: Label Detection (Ending With `:`)

Items ending with `:` are section headings / labels:
```python
if text.endswith(":"):
    # "Required commands:", "Note:", etc. → audit rule
```

### Guard 4: Prose-Starting Word Detection

After `shlex.split()`, if the first token is a common English word that cannot
be a command name, treat as prose:
```python
if argv[0].lower() in {"the", "this", "verification", "note", ...}:
    # prose → audit rule
```

### Guard 5: Env-Assignment Wrapping

If the first token after `shlex.split()` contains `=` (an env variable assignment
like `CARGO_HOME=...`), the entire command must be wrapped in `bash -lc` because
`subprocess.run` treats `argv[0]` as the executable:
```python
if "=" in argv[0] and not argv[0].startswith("-"):
    commands.append(["bash", "-lc", text])
```

This produces: `["bash", "-lc", "CARGO_HOME=$PWD/TMP cargo test"]`

## Complete Implementation

```python
def _parse_verification(raw: str) -> tuple[list[list[str]], list[str]]:
    commands: list[list[str]] = []
    audit_rules: list[str] = []
    for item in _iter_list_items(raw):
        if item.lower() == "none":
            continue
        # Guard 1: strip outer backticks
        text = item.strip()
        if text.startswith("`") and text.endswith("`"):
            text = text[1:-1].strip()
        # Guard 2: inline backticks → prose
        if "`" in text:
            audit_rules.append(item)
            continue
        # Guard 3: label ending with ':'
        if text.endswith(":"):
            audit_rules.append(item)
            continue
        try:
            argv = shlex.split(text)
        except ValueError:
            audit_rules.append(item)
            continue
        if not argv or not argv[0].strip():
            audit_rules.append(item)
            continue
        # Guard 4: common prose-starting words
        if argv[0].lower() in PROSE_WORDS:
            audit_rules.append(item)
            continue
        # Guard 5: env assignment → wrap in bash -lc
        if "=" in argv[0] and not argv[0].startswith("-"):
            commands.append(["bash", "-lc", text])
        else:
            commands.append(argv)
    return commands, audit_rules
```

`PROSE_WORDS` set: `the`, `a`, `an`, `any`, `all`, `this`, `that`, `these`,
`those`, `if`, `note`, `required`, `each`, `every`, `both`, `some`, `no`,
`verification`, `review`, `reviewer`, `completion`, `evidence`, `boundaries`,
`commands`, `command`.

## Common Pitfalls

| Input | Old Behavior | Fixed Behavior |
|---|---|---|
| `Required commands:` | `["Required", "commands:"]` executed | audit rule |
| `` `CARGO_HOME=... cargo test` `` | backtick in argv[0], broken | `["bash", "-lc", "CARGO_HOME=... cargo test"]` |
| `The second command requires INPUT/` | `["The", "second", ...]` executed | audit rule |
| `see \`INPUT/\` directory` | `["see", "\`INPUT/\`", "directory"]` executed | audit rule (inline backtick) |
