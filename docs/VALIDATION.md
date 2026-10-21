# Initial source release validation

Validated on 2026-10-21 with Godot 4.6.3 standard edition on Windows.

- Fresh resource import: passed.
- Main scene and start menu smoke check: passed.
- 24 gameplay/menu regression probes: passed, with explicit success markers and no engine error lines.
- Desktop rendering: main menu and level 26 rendered using the Compatibility renderer; the images in `docs/screenshots/` come from this run.
- Runtime resource references and local Markdown links: resolved.
- Release contents checked for known credential patterns, private machine paths, signing files, oversized files, and unwanted build/history artifacts: no findings in the prepared snapshot.

Game source, scene, project configuration, and shipped game assets are unchanged from the selected development snapshot. Release preparation adds documentation, license notices, a test runner, screenshots, and explicit audio/scene teardown in the existing test probes. The test runner rewrites the save path only in its disposable copy.

This validation does not constitute an Android device playthrough, an exported binary certification, or an exhaustive security audit. The repository's GitHub Actions workflow checks fresh import, startup, and the same 24 probes on Linux.
