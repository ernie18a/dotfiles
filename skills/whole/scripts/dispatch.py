# /// script
# requires-python = ">=3.12,<3.15"
# dependencies = []
# ///
import asyncio
import ctypes
import json
import os
import signal
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import cast

MODEL = "sonnet"
CEILING = 8
THRESHOLD = 85.0
PR_SET_PDEATHSIG = 1
LIBC = ctypes.CDLL("libc.so.6", use_errno=True)


@dataclass(frozen=True)
class Unit:
    id: str
    text: str


def deathsig() -> None:
    LIBC.prctl(PR_SET_PDEATHSIG, signal.SIGKILL)


def cpu() -> float:
    return os.getloadavg()[0] / len(os.sched_getaffinity(0)) * 100


def memory() -> float:
    info = {
        k: int(v.split()[0])
        for k, v in (line.split(":", 1) for line in Path("/proc/meminfo").read_text().splitlines())
    }
    return (1 - info["MemAvailable"] / info["MemTotal"]) * 100


async def call(prompt: str, schema: str, unit: Unit, out: Path, procs: set[asyncio.subprocess.Process]) -> None:
    proc = await asyncio.create_subprocess_exec(
        "claude",
        "-p",
        "--safe-mode",
        "--model",
        MODEL,
        "--tools",
        "",
        "--no-session-persistence",
        "--output-format",
        "json",
        "--json-schema",
        schema,
        "--system-prompt",
        prompt,
        stdin=asyncio.subprocess.PIPE,
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE,
        preexec_fn=deathsig,
        start_new_session=True,
    )
    procs.add(proc)
    stdout, stderr = await proc.communicate(unit.text.encode("utf-8"))
    procs.discard(proc)
    if proc.returncode != 0:
        raise RuntimeError(f"{unit.id}: {stderr.decode('utf-8')}")
    result = json.loads(stdout)
    if result["is_error"]:
        raise RuntimeError(f"{unit.id}: {result['result']}")
    target = out / f"{unit.id}.json"
    tmp = out / f"{unit.id}.tmp"
    tmp.write_text(json.dumps(result["structured_output"], ensure_ascii=False), encoding="utf-8")
    os.replace(tmp, target)


async def run(prompt: str, schema: str, units: list[Unit], out: Path) -> None:
    loop = asyncio.get_running_loop()
    loop.add_signal_handler(signal.SIGTERM, cast(asyncio.Task[None], asyncio.current_task()).cancel)
    done = {p.stem for p in out.glob("*.json")}
    queue = [u for u in reversed(units) if u.id not in done]
    procs: set[asyncio.subprocess.Process] = set()
    tasks: set[asyncio.Task[None]] = set()
    try:
        while queue or tasks:
            if queue and len(tasks) < CEILING and cpu() < THRESHOLD and memory() < THRESHOLD:
                tasks.add(asyncio.create_task(call(prompt, schema, queue.pop(), out, procs)))
            if tasks:
                finished, tasks = await asyncio.wait(tasks, timeout=1, return_when=asyncio.FIRST_COMPLETED)
                for task in finished:
                    task.result()
            else:
                await asyncio.sleep(1)
    finally:
        for proc in procs:
            if proc.returncode is None:
                os.killpg(proc.pid, signal.SIGKILL)
        for task in tasks:
            task.cancel()
        await asyncio.gather(*tasks, return_exceptions=True)
        for proc in procs:
            await proc.wait()


def main() -> None:
    prompt = Path(sys.argv[1]).read_text(encoding="utf-8")
    schema = Path(sys.argv[2]).read_text(encoding="utf-8")
    out = Path(sys.argv[3])
    out.mkdir(parents=True, exist_ok=True)
    units = [Unit(id=str(r["id"]), text=str(r["text"])) for r in map(json.loads, sys.stdin)]
    asyncio.run(run(prompt, schema, units, out))


main()
