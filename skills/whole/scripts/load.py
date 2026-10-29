# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import json
import sqlite3
import sys
from pathlib import Path

type Scalar = str | int | float | None


def scalar(value: object) -> Scalar:
    match value:
        case bool():
            return int(value)
        case str() | int() | float() | None:
            return value
        case _:
            raise TypeError(f"非純量欄位值：{value!r}")


def main() -> None:
    db = sys.argv[1]
    table = sys.argv[2]
    rows: list[dict[str, Scalar]] = []
    for d in map(Path, sys.argv[3:]):
        for p in sorted(d.glob("*.json")):
            data = json.loads(p.read_text(encoding="utf-8"))
            for i, r in enumerate(data["rows"]):
                row: dict[str, Scalar] = {"id": f"{d.parent.name}/{p.stem}/{i}", "unit": p.stem}
                row.update({str(k): scalar(v) for k, v in r.items()})
                rows.append(row)
    columns = ["id", "unit"] + sorted({k for r in rows for k in r} - {"id", "unit"})
    quoted = ", ".join(f'"{c}"' for c in columns)
    con = sqlite3.connect(db)
    with con:
        con.execute(f'DROP TABLE IF EXISTS "{table}"')
        con.execute(f'CREATE TABLE "{table}" ({quoted}, PRIMARY KEY (id))')
        con.executemany(
            f'INSERT INTO "{table}" ({quoted}) VALUES ({", ".join("?" for _ in columns)})',
            [tuple(r.get(c) for c in columns) for r in rows],
        )
    con.close()


main()
