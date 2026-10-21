# Regression probes

Run the suite through `python tools/run_tests.py --godot <executable>` from the repository root. Python 3.10+ and Godot 4.6.3 standard edition are required.

The 24 probes were carried over from game development. They exercise menus and saved settings, level selection, tutorial retries, reward calculations, shot limits and decay, wall collisions, mixed colors and launcher limits, missiles, shields/spikes, crystal impacts, black-hole swallowing, power-up purchase/help flows, furball behavior, and the end-of-demo dialog.

The runner copies the project into an ignored `.test-runs/run-*/project` directory. **Only inside that disposable copy**, it changes `SAVE_PATH` from `user://popem_progress.cfg` to `res://test_progress.cfg` and gives the project a test-specific name. It removes that exact test save between probes. Runtime logs are also redirected into the run directory. The original source and player progress are left intact.

Windows AppData and Linux XDG directories are redirected for the child process only, so editor preferences and caches are isolated as well. The probes stop audio playback and release their scene before quitting; gameplay assertions are unchanged from the original development probes. Windows console-wrapper paths are resolved to the sibling engine executable when available so timeouts can stop the actual process.

Passing requires a zero exit code, no Godot error lines, and the probe's explicit `_OK` marker. A startup smoke check and fresh resource import run first. Each process has a bounded timeout. Results and logs remain under `.test-runs/` for diagnosis; that folder is never committed.

These are behavioral regression checks, not exhaustive playthroughs. They do not establish that all levels are balanced or that every Android device, GPU, display ratio, and audio setup is supported.
