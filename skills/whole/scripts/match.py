# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import sqlite3
import sys
from collections import Counter


def main() -> None:
    con = sqlite3.connect(sys.argv[1])
    table = sys.argv[2]
    expected = Counter(str(r[0]) for r in con.execute(sys.argv[3]))
    got = Counter(str(r[0]) for r in con.execute(f'SELECT ref FROM "{table}"'))
    con.close()
    errors = [f"缺判定：{i}" for i in sorted(expected.keys() - got.keys())]
    errors += [f"多出判定：{i}" for i in sorted(got.keys() - expected.keys())]
    errors += [f"重複判定：{i} × {n}" for i, n in sorted(got.items()) if n > 1]
    for e in errors:
        sys.stderr.write(e + "\n")
    sys.exit(1 if errors else 0)


main()
