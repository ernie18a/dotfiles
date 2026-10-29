# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import json
import sqlite3
import sys
from pathlib import Path


def main() -> None:
    lines = Path(sys.argv[1]).read_text(encoding="utf-8").splitlines()
    rows = [json.loads(line) for line in lines]
    con = sqlite3.connect(sys.argv[2])
    with con:
        con.execute("DROP TABLE IF EXISTS units")
        con.execute("CREATE TABLE units (id TEXT PRIMARY KEY, path TEXT, first INTEGER, last INTEGER)")
        con.executemany(
            "INSERT INTO units VALUES (?, ?, ?, ?)",
            [(str(r["id"]), str(r["path"]), int(r["first"]), int(r["last"])) for r in rows],
        )
    con.close()


main()
