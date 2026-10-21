extends SceneTree

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	var saved_level: int = game.current_level
	var saved_highest: int = game.highest_level
	var saved_coins: int = game.coin_count

	game.current_level = 17
	game.highest_level = 17
	game._show_start_menu()
	if game.level_select_active:
		failures.append("level select must not be open on menu entry")

	# CONTINUE opens the level-select panel instead of starting directly.
	game._layout_start_menu_buttons()
	var continue_rect: Rect2 = game.start_menu_buttons.get("continue", Rect2())
	game._handle_start_menu_press(continue_rect.get_center())
	if not game.level_select_active:
		failures.append("CONTINUE should open the level select panel")
	if not game.menu_active:
		failures.append("menu must stay active while picking")

	# Tapping a locked level does nothing.
	var locked_rect: Rect2 = game.level_select_buttons.get("level_25", Rect2())
	game._handle_level_select_press(locked_rect.get_center())
	if not game.level_select_active or not game.menu_active:
		failures.append("locked level tap must be ignored")

	# Tapping a cleared level starts it.
	var pick_rect: Rect2 = game.level_select_buttons.get("level_5", Rect2())
	game._handle_level_select_press(pick_rect.get_center())
	if game.menu_active or game.level_select_active:
		failures.append("picking level 5 should leave the menu")
	if game.current_level != 5:
		failures.append("picked level should be 5, got %d" % game.current_level)
	if game.highest_level != 17:
		failures.append("replaying must not change highest_level, got %d" % game.highest_level)

	# Completing a replayed level advances current but never lowers highest.
	game._save_progress(6)
	if game.highest_level != 17:
		failures.append("saving progress 6 must keep highest at 17, got %d" % game.highest_level)

	# Progressing past the old highest raises it.
	game._save_progress(18)
	if game.highest_level != 18:
		failures.append("saving progress 18 should raise highest, got %d" % game.highest_level)

	# BACK closes the panel.
	game._show_start_menu()
	game._handle_start_menu_press(continue_rect.get_center())
	var back_rect: Rect2 = game.level_select_buttons.get("back", Rect2())
	game._handle_level_select_press(back_rect.get_center())
	if game.level_select_active:
		failures.append("BACK should close the level select panel")
	if not game.menu_active:
		failures.append("BACK should stay on the start menu")

	# restore shared save
	game.current_level = saved_level
	game.highest_level = saved_highest
	game.coin_count = saved_coins
	game._save_progress(saved_level)

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("LEVEL_SELECT_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
