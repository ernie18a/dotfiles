# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import json
import sqlite3
import sys

SIZE = 100


def cell(value: object) -> str:
    return " ".join(str(value).split())


def main() -> None:
    con = sqlite3.connect(sys.argv[1])
    cursor = con.execute(sys.argv[2])
    header = "\t".join(d[0] for d in cursor.description)
    rows = cursor.fetchall()
    for k in range(0, len(rows), SIZE):
        body = "\n".join("\t".join(cell(v) for v in r) for r in rows[k : k + SIZE])
        batch = {"id": f"b{k // SIZE:05d}", "text": f"{header}\n{body}"}
        sys.stdout.write(json.dumps(batch, ensure_ascii=False) + "\n")
    con.close()


main()
