"""Run POP'EM regression probes in a separate project and save directory."""
from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ERROR_LINE = re.compile(r"^(?:SCRIPT ERROR:|ERROR:|Parse Error:)", re.MULTILINE)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--godot", default="godot", help="Godot 4.6.3 console executable")
    args = parser.parse_args()
    executable = shutil.which(args.godot)
    if executable is None:
        parser.error("Godot executable not found; pass its full path with --godot")
    executable = str(Path(executable).resolve())
    # The Windows console launcher spawns a second process. Run its sibling
    # directly so a timeout cannot leave the child holding the output pipe.
    if os.name == "nt" and executable.endswith("_console.exe"):
        sibling = Path(executable.removesuffix("_console.exe") + ".exe")
        if sibling.is_file():
            executable = str(sibling)
    runs = ROOT / ".test-runs"
    runs.mkdir(exist_ok=True)
    run = Path(tempfile.mkdtemp(prefix="run-", dir=runs)).resolve()
    assert run.is_relative_to(runs.resolve())
    project = run / "project"
    project.mkdir()
    env = os.environ.copy()
    for key in ("APPDATA", "LOCALAPPDATA", "XDG_DATA_HOME", "XDG_CONFIG_HOME", "XDG_CACHE_HOME"):
        directory = run / "runtime" / key.lower()
        directory.mkdir(parents=True)
        env[key] = str(directory)
    for key, engine in (("APPDATA", "Godot"), ("XDG_DATA_HOME", "godot")):
        (Path(env[key]) / engine / "app_userdata" / "POP_EM_Regression").mkdir(parents=True)
    for directory in ("assets", "scripts", "scenes", "tests"):
        shutil.copytree(ROOT / directory, project / directory)
    settings = (ROOT / "project.godot").read_text(encoding="utf-8-sig")
    settings = re.sub(r'^config/name=.*$', 'config/name="POP_EM_Regression"', settings, flags=re.MULTILINE)
    (project / "project.godot").write_text(settings, encoding="utf-8")
    source = project / "scripts/main.gd"
    text = source.read_text(encoding="utf-8-sig")
    old = 'const SAVE_PATH := "user://popem_progress.cfg"'
    if text.count(old) != 1:
        raise RuntimeError("Save-path isolation needs updating; refusing to run against real progress")
    source.write_text(text.replace(old, 'const SAVE_PATH := "res://test_progress.cfg"'), encoding="utf-8")
    results = []

    def execute(name: str, extra: list[str], timeout: int, marker: bool = False) -> bool:
        command = [executable, "--headless", "--path", str(project), "--log-file", str(run / (name + ".engine.log")), *extra]
        try:
            result = subprocess.run(command, env=env, capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=timeout)
            output, code = result.stdout + result.stderr, result.returncode
            output = re.sub(r"\x1b\[[0-9;]*m", "", output)
        except subprocess.TimeoutExpired:
            output, code = "Process timed out\n", -1
        (run / (name + ".log")).write_text(output, encoding="utf-8")
        ok = code == 0 and not ERROR_LINE.search(output)
        if marker:
            ok = ok and bool(re.search(r"^[A-Z0-9_]+_OK$", output, re.MULTILINE))
        results.append({"name": name, "passed": bool(ok), "exit_code": code})
        print(("PASS " if ok else "FAIL ") + name, flush=True)
        if not ok:
            print(output[-2500:], flush=True)
        return bool(ok)

    if execute("import", ["--editor", "--import", "--quit"], 180):
        execute("startup", ["--script", "res://tests/smoke.gd"], 60, marker=True)
        probes = sorted((project / "tests").glob("probe_*.gd"))
        if not probes:
            raise RuntimeError("No regression probes found")
        for probe in probes:
            test_save = project / "test_progress.cfg"
            assert test_save.resolve().is_relative_to(project.resolve())
            test_save.unlink(missing_ok=True)
            execute(probe.stem, ["--script", "res://tests/" + probe.name], 60, marker=True)
    summary = {"results": results, "passed": sum(x["passed"] for x in results), "total": len(results)}
    (run / "results.json").write_text(json.dumps(summary, indent=2), encoding="utf-8")
    print(f"{summary['passed']}/{summary['total']} checks passed. Logs: {run}", flush=True)
    return 0 if len(results) >= 3 and all(x["passed"] for x in results) else 1


if __name__ == "__main__":
    raise SystemExit(main())
