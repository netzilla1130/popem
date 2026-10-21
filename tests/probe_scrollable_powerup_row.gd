extends SceneTree

func _slot_center(rect: Rect2) -> Vector2:
	return rect.position + rect.size * 0.5

func _set_help_seen(game) -> void:
	for help_id in ["aimer", "freeze", "bomb", "crystal", "antimatter", "missile"]:
		game.powerup_help_seen[help_id] = true

func _tap_slot(game, powerup_id: String) -> void:
	game._layout_powerup_slots()
	var rect: Rect2 = game.powerup_slots[powerup_id]
	var center: Vector2 = _slot_center(rect)
	game._begin_powerup_touch(center)
	game._release_powerup_touch(center)

func _scroll_bar(game, pixels: float) -> void:
	game._layout_powerup_slots()
	var start: Vector2 = game.powerup_bar_rect.position + Vector2(game.powerup_bar_rect.size.x * 0.5, game.powerup_bar_rect.size.y * 0.5)
	var finish: Vector2 = start + Vector2(pixels, 0.0)
	game._begin_powerup_touch(start)
	game._update_powerup_touch(finish)
	game._release_powerup_touch(finish)

func _check_one_row_layout(game, expected_count: int, should_scroll: bool, failures: Array[String], label: String) -> void:
	game._layout_powerup_slots()
	if game.powerup_slots.size() != expected_count:
		failures.append("%s slot count %d" % [label, game.powerup_slots.size()])
	if game._powerup_bar_rows() != 1:
		failures.append("%s should use one powerup row" % label)
	var y_values: Dictionary = {}
	var previous_right := -99999.0
	for slot_id in game._visible_powerup_slot_ids():
		var rect: Rect2 = game.powerup_slots[String(slot_id)]
		if rect.size.x < 62.0 or rect.size.y < 62.0:
			failures.append("%s slot %s too small" % [label, slot_id])
		y_values[int(round(rect.position.y))] = true
		if rect.position.x < previous_right - 0.01:
			failures.append("%s slot order overlaps near %s" % [label, slot_id])
		previous_right = rect.position.x + rect.size.x
	if y_values.size() != 1:
		failures.append("%s should have exactly one visible y row" % label)
	if should_scroll and game.powerup_scroll_max <= 1.0:
		failures.append("%s should have positive scroll range" % label)
	if not should_scroll and game.powerup_scroll_max > 0.01:
		failures.append("%s should fit without scrolling" % label)

func _init() -> void:
	root.size = Vector2i(540, 960)
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []

	game.current_level = 11
	game._start_level()
	game._clear_level_intro()
	_check_one_row_layout(game, 9, true, failures, "pre-mix")

	game.current_level = 26
	game._start_level()
	game._clear_level_intro()
	_set_help_seen(game)
	_check_one_row_layout(game, 9, true, failures, "mix")
	if game._powerup_slot_is_visible(game.powerup_slots["missile"]):
		failures.append("missile should start offscreen enough to require scrolling")

	game.balls.clear()
	game._spawn_target_ball("red", Vector2(game.arena.position.x + 120.0, game.arena.position.y + 180.0), 0)
	game.coin_count = 1000
	var red_bomb_center: Vector2 = _slot_center(game.powerup_slots["bomb_red"])
	game._begin_powerup_touch(red_bomb_center)
	game._update_powerup_touch(red_bomb_center + Vector2(-90.0, 0.0))
	game._release_powerup_touch(red_bomb_center + Vector2(-90.0, 0.0))
	if game.coin_count != 1000 or game.target_freeze_timer > 0.0 or game.powerup_flash_timer > 0.0:
		failures.append("horizontal powerup drag should scroll, not buy/use a powerup")
	if game.powerup_scroll_offset <= 1.0:
		failures.append("horizontal powerup drag should advance scroll offset")

	game.powerup_scroll_offset = 0.0
	game._layout_powerup_slots()
	var freeze_center: Vector2 = _slot_center(game.powerup_slots["freeze"])
	game.drag_active = true
	game.coin_count = 1000
	game._begin_powerup_touch(freeze_center)
	game._release_powerup_touch(freeze_center)
	if game.coin_count != 1000 or game.target_freeze_timer > 0.0:
		failures.append("powerup touch during launcher drag should be ignored")
	if not game.drag_active:
		failures.append("blocked powerup touch should not release launcher drag")
	game.drag_active = false

	game.coin_count = 1000
	_tap_slot(game, "freeze")
	if not game.powerup_confirm_active or game.powerup_confirm_id != "freeze":
		failures.append("tap on visible freeze should open confirm dialog")
	game._handle_powerup_confirm_press(game.powerup_confirm_ok_rect.get_center())
	if game.coin_count != 910 or game.target_freeze_timer <= 0.0:
		failures.append("confirming freeze should buy and apply")

	game.target_freeze_timer = 0.0
	game.coin_count = 1000
	game.armed_special_kind = ""
	_scroll_bar(game, -1200.0)
	if game.powerup_scroll_offset < game.powerup_scroll_max - 0.01:
		failures.append("large left swipe should clamp to scroll max")
	var missile_rect: Rect2 = game.powerup_slots["missile"]
	if not game._powerup_slot_is_visible(missile_rect):
		failures.append("missile should be visible after scrolling to the end")
	else:
		var missile_center: Vector2 = _slot_center(missile_rect)
		game._begin_powerup_touch(missile_center)
		game._release_powerup_touch(missile_center)
		if game.coin_count != 780 or game.armed_special_kind != "missile":
			failures.append("tap on scrolled missile should buy and arm missile")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("SCROLLABLE_POWERUP_ROW_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
