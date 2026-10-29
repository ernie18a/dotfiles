# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import ctypes
import os
import signal
import subprocess
import sys
from pathlib import Path
from types import FrameType

SCRIPTS = Path(__file__).resolve().parent
NULL = Path(os.devnull)
PR_SET_PDEATHSIG = 1
LIBC = ctypes.CDLL("libc.so.6", use_errno=True)
REVIEW = "\n\n下方「# 已抽取」列出這段原文已抽取的列。只輸出原文中遺漏的列，已抽取的不要重複輸出，沒有遺漏時 rows 為空陣列。\n"
procs: list[subprocess.Popen[bytes]] = []


def deathsig() -> None:
    LIBC.prctl(PR_SET_PDEATHSIG, signal.SIGKILL)


def terminate(signum: int, frame: FrameType | None) -> None:
    raise SystemExit(128 + signum)


def spawn(script: str, args: list[str], source: Path, target: Path) -> None:
    with source.open("rb") as fin, target.open("wb") as fout:
        proc = subprocess.Popen(
            [sys.executable, str(SCRIPTS / script), *args],
            stdin=fin,
            stdout=fout,
            preexec_fn=deathsig,
            start_new_session=True,
        )
        procs.append(proc)
        code = proc.wait()
        procs.remove(proc)
    if code != 0:
        raise SystemExit(f"{script} 失敗，結束碼 {code}")


def run(script: str, args: list[str], source: Path) -> None:
    spawn(script, args, source, NULL)


def pipe(script: str, args: list[str], source: Path, target: Path) -> None:
    tmp = target.with_name(target.name + ".tmp")
    spawn(script, args, source, tmp)
    os.replace(tmp, target)


def dispatch(task: Path, schema: Path, source: Path) -> None:
    run("dispatch.py", [str(task / "prompt.md"), str(schema), str(task / "out")], source)


def extract(src: str, w: Path) -> None:
    units = w / "units.jsonl"
    db = str(w / "db.sqlite")
    schema = w / "extract" / "schema.json"
    review = w / "review"
    pipe("units.py", [src], NULL, units)
    run("index.py", [str(units), db], NULL)
    dispatch(w / "extract", schema, units)
    run("load.py", [db, "facts", str(w / "extract" / "out")], NULL)
    review.mkdir(exist_ok=True)
    (review / "prompt.md").write_text((w / "extract" / "prompt.md").read_text(encoding="utf-8") + REVIEW, encoding="utf-8")
    pipe("review.py", [str(units), db], NULL, review / "units.jsonl")
    dispatch(review, schema, review / "units.jsonl")
    outs = [str(w / "extract" / "out"), str(review / "out")]
    run("load.py", [db, "facts", *outs], NULL)
    run("cover.py", [src, str(units), db, "facts", *outs], NULL)
    usage = (SCRIPTS.parent / "USAGE.md").read_text(encoding="utf-8")
    (w / "USAGE.md").write_text(usage.replace("{main}", str(SCRIPTS / "main.py")).replace("{src}", src).replace("{w}", str(w)), encoding="utf-8")


def judge(w: Path, name: str, sql: str) -> None:
    db = str(w / "db.sqlite")
    task = w / name
    pipe("rows.py", [db, sql], NULL, task / "units.jsonl")
    dispatch(task, task / "schema.json", task / "units.jsonl")
    run("load.py", [db, name, str(task / "out")], NULL)
    run("match.py", [db, name, sql], NULL)


def scan(src: str, w: Path, name: str) -> None:
    db = str(w / "db.sqlite")
    task = w / name
    dispatch(task, task / "schema.json", w / "units.jsonl")
    run("load.py", [db, name, str(task / "out")], NULL)
    run("cover.py", [src, str(w / "units.jsonl"), db, name, str(task / "out")], NULL)


def main() -> None:
    signal.signal(signal.SIGTERM, terminate)
    try:
        match sys.argv[1:]:
            case ["extract", src, w]:
                extract(src, Path(w))
            case ["judge", w, name, sql]:
                judge(Path(w), name, sql)
            case ["scan", src, w, name]:
                scan(src, Path(w), name)
            case _:
                raise SystemExit("用法：main.py extract <來源> <工作> | judge <工作> <名稱> <SQL> | scan <來源> <工作> <名稱>")
    finally:
        for proc in procs:
            os.killpg(proc.pid, signal.SIGKILL)
            proc.wait()


main()
