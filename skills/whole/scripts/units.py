# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import json
import sys
from pathlib import Path

LIMIT = 12000


def spans(lines: list[str]) -> list[tuple[int, int]]:
    out: list[tuple[int, int]] = []
    start = 0
    size = 0
    for i, line in enumerate(lines):
        size += len(line) + 1
        if size >= LIMIT:
            out.append((start, i + 1))
            start = i + 1
            size = 0
    if start < len(lines):
        out.append((start, len(lines)))
    return out


def main() -> None:
    src = Path(sys.argv[1])
    for path in sorted(src.glob("*.md")):
        lines = path.read_text(encoding="utf-8").splitlines()
        for k, (a, b) in enumerate(spans(lines)):
            body = "\n".join(f"{n + 1}\t{lines[n]}" for n in range(a, b))
            unit = {
                "id": f"{path.name}#{k:04d}",
                "path": str(path),
                "first": a + 1,
                "last": b,
                "text": f"# {path.name}\n{body}",
            }
            sys.stdout.write(json.dumps(unit, ensure_ascii=False) + "\n")


main()
