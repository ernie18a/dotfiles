# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import json
import sqlite3
import sys
from pathlib import Path


def main() -> None:
    units = [json.loads(line) for line in Path(sys.argv[1]).read_text(encoding="utf-8").splitlines()]
    con = sqlite3.connect(sys.argv[2])
    for u in units:
        facts = con.execute("SELECT line, quote FROM facts WHERE unit = ? ORDER BY line", (str(u["id"]),)).fetchall()
        listed = "\n".join(f"{line}\t{quote}" for line, quote in facts)
        text = f"{u['text']}\n\n# 已抽取\n{listed}"
        sys.stdout.write(json.dumps({"id": str(u["id"]), "text": text}, ensure_ascii=False) + "\n")
    con.close()


main()
