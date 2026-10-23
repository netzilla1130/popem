# POP'EM! / 彩弹爆爆

A portrait arcade puzzle game built with **Godot 4.6** and GDScript. Pull back a colored ball, aim, and release to pop matching targets. Later levels introduce repainting walls, tougher targets, black holes, merging targets, and color mixing.

[简体中文说明](README.zh-CN.md) · [Contributing](CONTRIBUTING.md) · [Licenses and asset credits](THIRD_PARTY_NOTICES.md)

<p><img src="docs/screenshots/menu.png" alt="POP'EM start menu" width="270"> <img src="docs/screenshots/gameplay.png" alt="Level 26 with mixed-color targets" width="270"></p>

## Play from source

1. Install the **standard (non-.NET) Godot 4.6.3** editor from [godotengine.org](https://godotengine.org/download/).
2. Clone this repository, or download its ZIP and extract it.
3. Import `project.godot` in Godot. Let the first asset import finish.
4. Press **F6** with `scenes/main.tscn` open, or **F5** to run the project.

No account, API key, paid service, or additional plugin is needed. All required game assets are included. The project uses the Mobile renderer; if a desktop GPU does not support it, try:

```sh
godot --path . --rendering-method gl_compatibility
```

Use your mouse or touchscreen to drag a launcher ball down or sideways, then release. Match its color to a target. From level 26, drag one primary color onto another to mix: red + yellow = orange, yellow + blue = green, red + blue = purple. The in-game tutorials explain new mechanics as they unlock.

## What's included

- **30 levels** arranged in six groups of five.
- Aim assistance, color bombs, freeze, crystal balls, antimatter, tracking missiles, and a furball power-up.
- English, Simplified Chinese, and Traditional Chinese menus and help.
- Local progress, level selection, earned coins, and volume settings. Coins are in-game rewards; this source edition contains no payment integration.
- Custom ball simulation, procedural impact sounds, particles, and animated UI.
- 25 regression probes covering gameplay, menus, progression, power-ups, and canceled touch gestures.

This is the initial public source edition of the existing 30-level game. The game still uses the original “demo complete” end screen. Further levels and a full commercial release are not promised by this repository.

## Development and tests

The game itself only needs Godot. To run the regression suite, install **Python 3.10+** as well:

```sh
python tools/run_tests.py --godot godot
```

On Windows, pass the console executable if needed:

```powershell
python tools/run_tests.py --godot "D:/Tools/Godot/Godot_v4.6.3-stable_win64_console.exe"
```

The runner creates an isolated project under `.test-runs/`, redirects the test copy's save file, imports resources, checks startup, and runs every probe. It checks exit status, Godot errors, and success markers. It does not overwrite a player's saved progress. Logs and a JSON result remain in that ignored directory for inspection. See [tests/README.md](tests/README.md).

| Path | Purpose |
| --- | --- |
| `scripts/main.gd` | Gameplay, levels, input, drawing, audio, save data, localization |
| `scenes/main.tscn` | Main scene |
| `assets/` | Included visuals, audio, and licensed font |
| `tests/` | Regression probes |
| `tools/run_tests.py` | Cross-platform test runner; Python standard library only |

The implementation is currently concentrated in one script. Small, focused improvements are easier to review than a large architectural rewrite.

## Exporting

Use Godot's **Project → Export** and install matching 4.6.3 export templates. Add your own Windows, Linux, or Android preset. Android additionally needs a configured Android SDK and JDK supported by Godot. The repository intentionally does not contain store signing keys, Android build directories, or local export credentials. For a redistributed fork, choose your own application identifier and signing key.

## License and attribution

Project-owned code, documentation, artwork, and audio in this repository are offered under the [MIT License](LICENSE), to the extent the maintainer holds licensable rights. The art/audio includes AI-assisted material. **Fusion Pixel Font and its incorporated font components remain under SIL OFL 1.1**, with notices preserved in `assets/fonts/`.

Godot itself is a separately licensed MIT engine. Retain its license and relevant third-party notices when distributing an exported game. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). The MIT grant does not grant trademark rights to the POP'EM! or Netzilla Studio names or imply endorsement of a fork.
