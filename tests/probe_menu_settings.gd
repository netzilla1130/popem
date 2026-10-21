extends SceneTree

func settings_buttons_rect(game, button_id: String) -> Rect2:
	return game.settings_buttons.get(button_id, Rect2())

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []

	var original_language: String = game.settings_language
	var original_volume: float = game.settings_volume
	var original_level: int = game.current_level

	if not game.menu_active:
		failures.append("start menu should be active on boot")
	if game.settings_active:
		failures.append("settings overlay should be closed on boot")

	# Open SETTING from the main menu.
	var settings_rect: Rect2 = game.start_menu_buttons.get("settings", Rect2())
	if settings_rect.size.x <= 0.0:
		failures.append("main menu should expose a settings button rect")
	game._handle_start_menu_press(settings_rect.get_center())
	if not game.settings_active or not game.menu_active:
		failures.append("SETTING press should open settings overlay while staying in menu")

	# Normalize to a known state for deterministic checks.
	game.settings_language = "en"
	game.settings_volume = 1.0
	game._apply_audio_settings()

	# Three dedicated language buttons set the language directly and persist.
	var lang_zh_rect: Rect2 = game.settings_buttons.get("lang_zh", Rect2())
	var lang_zh_hant_rect: Rect2 = game.settings_buttons.get("lang_zh_hant", Rect2())
	var lang_en_rect: Rect2 = game.settings_buttons.get("lang_en", Rect2())
	if lang_zh_rect.size.x <= 0.0 or lang_zh_hant_rect.size.x <= 0.0 or lang_en_rect.size.x <= 0.0:
		failures.append("settings should expose three language button rects")
	game._handle_settings_press(lang_zh_rect.get_center())
	if game.settings_language != "zh":
		failures.append("lang_zh press should switch to zh")
	var config := ConfigFile.new()
	if config.load(game.SAVE_PATH) != OK or String(config.get_value("settings", "language", "")) != "zh":
		failures.append("language zh should be persisted to save file")
	game._handle_settings_press(lang_zh_hant_rect.get_center())
	if game.settings_language != "zh_hant":
		failures.append("lang_zh_hant press should switch to zh_hant")
	if game._t("CONTINUE") != "繼續遊戲":
		failures.append("zh_hant should translate via ZH_HANT_TEXTS")
	var hant_config := ConfigFile.new()
	if hant_config.load(game.SAVE_PATH) != OK or String(hant_config.get_value("settings", "language", "")) != "zh_hant":
		failures.append("language zh_hant should be persisted to save file")
	game._handle_settings_press(lang_en_rect.get_center())
	if game.settings_language != "en":
		failures.append("lang_en press should switch back to en")

	# Volume steps down in 25% increments, clamps at 0, applies to players.
	var volume_down_rect: Rect2 = game.settings_buttons.get("volume_down", Rect2())
	var volume_up_rect: Rect2 = game.settings_buttons.get("volume_up", Rect2())
	game._handle_settings_press(volume_down_rect.get_center())
	if not is_equal_approx(game.settings_volume, 0.75) or game._settings_volume_percent() != 75:
		failures.append("volume down from 100 should be 75")
	if game.audio_player != null and not is_equal_approx(game.audio_player.volume_db, linear_to_db(0.75)):
		failures.append("audio player volume_db should track 75% volume")
	if game.collision_audio_player != null and not is_equal_approx(game.collision_audio_player.volume_db, linear_to_db(0.75) - 9.0):
		failures.append("collision audio should keep -9 dB offset")
	for i in range(4):
		game._handle_settings_press(volume_down_rect.get_center())
	if not is_equal_approx(game.settings_volume, 0.0) or game._settings_volume_percent() != 0:
		failures.append("volume should clamp at 0")
	if game.audio_player != null and game.audio_player.volume_db > -79.0:
		failures.append("0% volume should mute audio player (-80 dB)")
	game._handle_settings_press(volume_up_rect.get_center())
	if not is_equal_approx(game.settings_volume, 0.25) or game._settings_volume_percent() != 25:
		failures.append("volume up from 0 should be 25")
	var volume_config := ConfigFile.new()
	if volume_config.load(game.SAVE_PATH) != OK or not is_equal_approx(float(volume_config.get_value("settings", "volume", -1.0)), 0.25):
		failures.append("volume 0.25 should be persisted to save file")
	for i in range(5):
		game._handle_settings_press(volume_up_rect.get_center())
	if not is_equal_approx(game.settings_volume, 1.0):
		failures.append("volume should clamp at 100")

	# A device tap arrives as a real touch plus an emulated mouse event;
	# the pair must register the language press exactly once.
	game.settings_language = "en"
	var language_center: Vector2 = (settings_buttons_rect(game, "lang_zh")).get_center()
	var touch := InputEventScreenTouch.new()
	touch.pressed = true
	touch.position = language_center
	game._input(touch)
	var emulated_mouse := InputEventMouseButton.new()
	emulated_mouse.button_index = MOUSE_BUTTON_LEFT
	emulated_mouse.pressed = true
	emulated_mouse.position = language_center
	emulated_mouse.device = InputEvent.DEVICE_ID_EMULATION
	game._input(emulated_mouse)
	if game.settings_language != "zh":
		failures.append("touch + emulated mouse should toggle language exactly once, got %s" % game.settings_language)
	game.settings_language = "en"

	# BACK closes settings but keeps the main menu.
	var back_rect: Rect2 = game.settings_buttons.get("back", Rect2())
	game._handle_settings_press(back_rect.get_center())
	if game.settings_active or not game.menu_active:
		failures.append("BACK should close settings and return to main menu")

	# CONTINUE opens the level-select panel; picking the current level starts it.
	var continue_rect: Rect2 = game.start_menu_buttons.get("continue", Rect2())
	game._handle_start_menu_press(continue_rect.get_center())
	if not game.level_select_active or not game.menu_active:
		failures.append("CONTINUE should open the level select panel")
	var current_chip: Rect2 = game.level_select_buttons.get("level_%d" % game.current_level, Rect2())
	game._handle_level_select_press(current_chip.get_center())
	if game.menu_active or game.settings_active or game.level_select_active:
		failures.append("picking the current level should leave the menu")
	if game.current_level != original_level:
		failures.append("CONTINUE flow should keep the saved level")

	# Restore original persisted settings.
	game.settings_language = original_language
	game.settings_volume = original_volume
	game._apply_audio_settings()
	game._save_progress(original_level)

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("MENU_SETTINGS_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
