# Contributing

Bug reports, accessibility improvements, localization corrections, and small gameplay fixes are welcome. Open an issue before a large redesign so the scope can be discussed.

For a bug report, include the Godot version, operating system, level number, language, steps to reproduce, expected behavior, and actual behavior. A short screenshot or video helps. Do not post personal save files or credentials unless you have removed sensitive information.

For a pull request:

1. Make a focused change on your fork.
2. Run `python tools/run_tests.py --godot <your-godot-executable>`.
3. Manually check affected visuals/input; headless tests do not validate appearance, audio quality, or real touch devices.
4. Describe the change and testing. Add a regression probe for a meaningful gameplay bug when practical.

The game currently keeps its logic in `scripts/main.gd`. Please avoid unrelated reformatting. New assets must have clear origins and compatible redistribution terms; add their notices to `THIRD_PARTY_NOTICES.md`. Contributions of project code are under MIT; existing font licenses remain unchanged.
