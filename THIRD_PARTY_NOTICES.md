# Third-party notices and asset provenance

## License boundaries

The root MIT license covers the maintainer's licensable rights in the project code, tests, documentation, and game artwork/audio. It does not replace third-party font or engine licenses. AI-assisted outputs may have different copyright protection in different jurisdictions; this repository makes no claim of exclusive rights in material that is not copyrightable.

| Material | Origin | License / treatment |
| --- | --- | --- |
| GDScript, scenes, regression probes | POP'EM! project / Netzilla Studio | MIT |
| `assets/ui/*.png`, `assets/app_icon.png` | Project artwork; includes AI-assisted assets | MIT to the extent of maintainer's rights |
| Background music, victory sound, supplied effects | Original or redistributable AI-generated project audio, as confirmed by the maintainer for this release | MIT to the extent of maintainer's rights |
| `assets/audio/praise/*.ogg` | Prerendered MiniMax speech using a service-provided voice | Included with maintainer-confirmed redistribution rights; no API access or voice model is bundled |
| `assets/audio/sfx/sfx_glass_shatter.ogg` and runtime-generated effects | Procedural synthesis | MIT |
| `assets/fonts/fusion_pixel.otf` | Fusion Pixel 12px proportional, Simplified Chinese variant; upstream v2026.07.01 | SIL OFL 1.1 |

## Fusion Pixel Font

- Upstream: <https://github.com/TakWolf/fusion-pixel-font>
- Copyright (c) 2022, TakWolf.
- Main license: [assets/fonts/fusion_pixel_OFL.txt](assets/fonts/fusion_pixel_OFL.txt).
- Upstream component notices are retained under [assets/fonts/LICENSES/](assets/fonts/LICENSES/): Ark Pixel, Cubic 11, and Galmuri. Those authors and their notices are not replaced by the root MIT license.
- The bundled OTF is copied without modification from `fusion-pixel-12px-proportional-zh_hans.otf`; only the local filename is shortened. Font derivatives must follow OFL terms, including applicable reserved-font-name requirements.

## Godot Engine

Godot is required to run/export this project and is not vendored as a binary here.

- Engine license: <https://godotengine.org/license/>
- Third-party notices: <https://github.com/godotengine/godot/blob/4.6.3-stable/COPYRIGHT.txt>

When distributing an exported game, include the Godot engine license and applicable engine third-party notices, as well as this project's MIT notice and the font notices. Godot's distribution obligations are separate from permission to use this project's code.

## Names

No trademark license is granted for POP'EM!, 彩弹爆爆, or Netzilla Studio. Descriptive attribution is welcome; do not imply that a modified release is an official release by the original maintainer.
