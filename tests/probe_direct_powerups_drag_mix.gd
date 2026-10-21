extends SceneTree

func _launcher_balls(game) -> Array:
	var launchers := []
	for ball in game.balls:
		if not ball.is_target:
			launchers.append(ball)
	return launchers

func _target_count(game) -> int:
	var count := 0
	for ball in game.balls:
		if ball.is_target:
			count += 1
	return count

func _press_powerup(game, powerup_id: String) -> void:
	game._layout_powerup_slots()
	var rect: Rect2 = game.powerup_slots[powerup_id]
	if not game._powerup_bar_contains_position(rect.get_center()):
		var shift: float = rect.get_center().x - game.powerup_bar_rect.get_center().x
		game.powerup_scroll_offset = clampf(game.powerup_scroll_offset + shift, 0.0, game.powerup_scroll_max)
		game._layout_powerup_slots()
		rect = game.powerup_slots[powerup_id]
	var center: Vector2 = rect.position + rect.size * 0.5
	game._handle_powerup_press(center)

func _drag_color_to(game, first_color: String, second_color: String) -> void:
	game._begin_drag(game._button_center(first_color))
	game._update_drag(game._button_center(second_color))
	var pull: Vector2 = game._button_center(second_color) + Vector2(0.0, game.button_radius * game.MAX_PULL_RADIUS_MULTIPLIER * 0.7)
	game._update_drag(pull)
	game._release_drag(pull)

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.current_level = 26
	game._start_level()
	game._clear_level_intro()
	for help_id in ["freeze", "bomb", "crystal", "antimatter", "missile"]:
		game.powerup_help_seen[help_id] = true

	game.balls.clear()
	game._spawn_target_ball("red", Vector2(game.arena.position.x + 120.0, game.arena.position.y + 180.0), 0)
	game.balls[0].hp = 2
	game.balls[0].max_hp = 2
	game.coin_count = 1000
	game.color_bomb_stock["red"] = 7
	_press_powerup(game, "bomb_red")
	if not game.powerup_confirm_active or game.powerup_confirm_id != "bomb_red":
		failures.append("instant bomb press should open confirm dialog")
	if game.coin_count != 1000:
		failures.append("confirm dialog should not charge before OK")
	game._handle_powerup_confirm_press(game.powerup_confirm_ok_rect.get_center())
	if game.coin_count != 880:
		failures.append("red bomb should charge once immediately, got coins %d" % game.coin_count)
	if game.color_bomb_stock["red"] != 7:
		failures.append("stored red bomb stock should be ignored and unchanged")
	if _target_count(game) != 1 or game.balls[0].hp != 2:
		failures.append("bomb must NOT hit before the delay")
	if game.pending_color_bombs.size() != 1:
		failures.append("confirm should queue one pending bomb")
	game._step_pending_bombs(game.COLOR_BOMB_DELAY * 0.5)
	if _target_count(game) != 1:
		failures.append("bomb must still be pending at half delay")
	game._step_pending_bombs(game.COLOR_BOMB_DELAY * 0.6)
	if _target_count(game) != 0:
		failures.append("bomb should DESTROY the red target outright (ignore HP) after the delay")
	if not game.pending_color_bombs.is_empty():
		failures.append("detonated bomb should leave the pending queue")
	if game.powerup_flash_id != "bomb_red" or game.powerup_flash_timer <= 0.0:
		failures.append("bomb purchase should flash its slot")

	game.balls.clear()
	game._spawn_target_ball("red", Vector2(game.arena.position.x + 120.0, game.arena.position.y + 180.0), 0)
	game.coin_count = 0
	game.freeze_stock = 5
	_press_powerup(game, "freeze")
	if not game.powerup_confirm_active or game.powerup_confirm_id != "freeze":
		failures.append("freeze press should open confirm dialog")
	game._handle_powerup_confirm_press(game.powerup_confirm_ok_rect.get_center())
	if game.target_freeze_timer > 0.0:
		failures.append("stored freeze stock should not activate without coins")
	if game.invalid_prompt_text != "Need %d coins." % game.FREEZE_COST:
		failures.append("stored freeze should still require coins")
	# tapping outside the OK button cancels the confirm without charging
	game.coin_count = 1000
	game.last_powerup_press_time = -1000.0
	_press_powerup(game, "freeze")
	if not game.powerup_confirm_active:
		failures.append("freeze press should re-open confirm dialog")
	game._handle_powerup_confirm_press(game.powerup_confirm_dialog_rect.position - Vector2(10.0, 10.0))
	if game.powerup_confirm_active or game.coin_count != 1000 or game.target_freeze_timer > 0.0:
		failures.append("tapping outside confirm OK should cancel without charge")

	game.coin_count = 1000
	game.crystal_stock = 5
	_press_powerup(game, "crystal")
	if game.coin_count != 600 or game.armed_special_kind != "crystal":
		failures.append("crystal should charge immediately and arm once")
	_press_powerup(game, "crystal")
	if game.coin_count != 600 or game.armed_special_kind != "crystal":
		failures.append("fast double-tap should be eaten by duplicate guard")
	game.last_powerup_press_time = -1000.0
	_press_powerup(game, "crystal")
	if game.armed_special_kind != "" or game.coin_count != 1000:
		failures.append("re-tap armed crystal should cancel and refund")
	game.last_powerup_press_time = -1000.0
	_press_powerup(game, "crystal")
	if game.coin_count != 600 or game.armed_special_kind != "crystal":
		failures.append("crystal should re-arm after cancel")
	game.last_powerup_press_time = -1000.0
	_press_powerup(game, "missile")
	if game.coin_count != 600 or game.armed_special_kind != "crystal":
		failures.append("clicking another powerup while armed should do nothing")
	game._launch_armed_special("red", 0.55, Vector2.UP)
	if game.armed_special_kind != "" or game.coin_count != 600:
		failures.append("firing crystal should clear arm without another charge")

	game.current_level = 26
	game._start_level()
	game._clear_level_intro()
	for help_id in ["freeze", "bomb", "crystal", "antimatter", "missile"]:
		game.powerup_help_seen[help_id] = true
	game.balls.clear()
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 110.0, game.arena.position.y + 180.0), 0)
	game.coin_count = 1000
	game._begin_drag(game._button_center("red"))
	game._update_drag(game._button_center("yellow"))
	if not game.drag_mix_locked or game.drag_mix_result_color != "orange":
		failures.append("dragging red onto yellow should lock an orange mix")
	if game.drag_color != "yellow":
		failures.append("mix lock should re-anchor drag to the target socket")
	game._release_drag(game._button_center("yellow"))
	if game.drag_mix_locked or game.shots_used != 0 or not _launcher_balls(game).is_empty():
		failures.append("weak release on locked mix should cancel without firing")
	_drag_color_to(game, "red", "yellow")
	var mixed_launchers := _launcher_balls(game)
	if game.shots_used != 1 or mixed_launchers.size() != 1:
		failures.append("drag mix should create exactly one mixed shot")
	elif mixed_launchers[0].color_name != "orange" or mixed_launchers[0].mix_batch_id != 0:
		failures.append("drag mix should directly launch orange fused ball")

	# pass-through fix: red dragged ACROSS yellow must still reach blue -> purple
	game.current_level = 26
	game._start_level()
	game._clear_level_intro()
	for help_id in ["freeze", "bomb", "crystal", "antimatter", "missile"]:
		game.powerup_help_seen[help_id] = true
	game.balls.clear()
	game._spawn_target_ball("purple", Vector2(game.arena.position.x + 140.0, game.arena.position.y + 180.0), 0)
	game.coin_count = 1000
	game._begin_drag(game._button_center("red"))
	game._update_drag(game._button_center("yellow"))
	if not game.drag_mix_locked or game.drag_mix_result_color != "orange":
		failures.append("passing over yellow should temporarily lock orange")
	game._update_drag(game._button_center("blue"))
	if game.drag_mix_result_color != "purple" or game.drag_color != "blue":
		failures.append("continuing onto blue should retarget the mix to purple")
	var purple_pull: Vector2 = game._button_center("blue") + Vector2(0.0, game.button_radius * game.MAX_PULL_RADIUS_MULTIPLIER * 0.7)
	game._update_drag(purple_pull)
	game._release_drag(purple_pull)
	var purple_launchers := _launcher_balls(game)
	if game.shots_used != 1 or purple_launchers.size() != 1 or purple_launchers[0].color_name != "purple":
		failures.append("pass-through drag should launch one purple ball")

	game.current_level = 26
	game._start_level()
	game._clear_level_intro()
	for help_id in ["freeze", "bomb", "crystal", "antimatter", "missile"]:
		game.powerup_help_seen[help_id] = true
	game.balls.clear()
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 110.0, game.arena.position.y + 180.0), 0)
	game.coin_count = 1000
	_press_powerup(game, "missile")
	if game.coin_count != 780 or game.armed_special_kind != "missile":
		failures.append("missile should charge immediately and stay armed")
	_drag_color_to(game, "red", "yellow")
	var missile_launchers := _launcher_balls(game)
	if game.armed_special_kind != "" or game.coin_count != 780:
		failures.append("mixed missile launch should clear arm without another charge")
	if missile_launchers.size() != 1 or missile_launchers[0].color_name != "orange" or missile_launchers[0].special_kind != "missile":
		failures.append("drag mix with armed missile should launch orange missile")

	game.coin_count = 777
	game.freeze_stock = 9
	game.crystal_stock = 8
	game.antimatter_stock = 7
	game.missile_stock = 6
	for color_name in game.POWERUP_BOMB_COLOR_ORDER:
		game.color_bomb_stock[color_name] = 5
	game._save_progress(26)
	game.freeze_stock = 1
	game.crystal_stock = 1
	game.antimatter_stock = 1
	game.missile_stock = 1
	for color_name in game.POWERUP_BOMB_COLOR_ORDER:
		game.color_bomb_stock[color_name] = 1
	game._load_progress()
	if game.coin_count != 777:
		failures.append("save/load should preserve coins")
	if game.freeze_stock != 0 or game.crystal_stock != 0 or game.antimatter_stock != 0 or game.missile_stock != 0:
		failures.append("save/load should clear stored special stocks")
	for color_name in game.POWERUP_BOMB_COLOR_ORDER:
		if int(game.color_bomb_stock.get(color_name, -1)) != 0:
			failures.append("save/load should clear stored bomb stock %s" % color_name)

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("DIRECT_POWERUPS_DRAG_MIX_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
