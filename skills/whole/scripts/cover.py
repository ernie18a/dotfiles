# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import json
import sqlite3
import sys
from collections import defaultdict
from pathlib import Path


def norm(text: str) -> str:
    return " ".join(text.split())


def raw(text: str) -> str:
    return "\n".join(line.split("\t", 1)[1] for line in text.splitlines()[1:])


def main() -> None:
    src = Path(sys.argv[1])
    units = {str(u["id"]): u for u in map(json.loads, Path(sys.argv[2]).read_text(encoding="utf-8").splitlines())}
    db = sys.argv[3]
    table = sys.argv[4]
    errors: list[str] = []
    spans: defaultdict[str, list[tuple[int, int]]] = defaultdict(list)
    for u in units.values():
        spans[str(u["path"])].append((int(u["first"]), int(u["last"])))
    for path in sorted(src.glob("*.md")):
        cursor = 1
        for a, b in sorted(spans[str(path)]):
            if a != cursor:
                errors.append(f"行未覆蓋：{path}:{cursor}-{a - 1}")
            cursor = b + 1
        total = len(path.read_text(encoding="utf-8").splitlines())
        if cursor != total + 1:
            errors.append(f"行未覆蓋：{path}:{cursor}-{total}")
    for d in map(Path, sys.argv[5:]):
        done = {p.stem for p in d.glob("*.json")}
        errors.extend(f"單位未處理：{d}/{i}" for i in sorted(units.keys() - done))
    con = sqlite3.connect(db)
    for rid, unit, line, quote in con.execute(f'SELECT id, unit, line, quote FROM "{table}"'):
        u = units[unit]
        if not int(u["first"]) <= int(line) <= int(u["last"]):
            errors.append(f"行號超出單位範圍：{rid} 行 {line}")
        if norm(str(quote)) not in norm(raw(str(u["text"]))):
            errors.append(f"原句不在原檔：{rid}")
    con.close()
    for e in errors:
        sys.stderr.write(e + "\n")
    sys.exit(1 if errors else 0)


main()
