extends SceneTree

func _target_count(game) -> int:
	var count := 0
	for ball in game.balls:
		if ball.is_target:
			count += 1
	return count

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.current_level = 11
	game.coin_count = 1000
	game._start_level()
	game._clear_level_intro()
	game._layout_powerup_slots()
	game.powerup_help_seen["freeze"] = false
	game.powerup_help_seen["bomb"] = false
	game.balls.clear()
	game._spawn_target_ball("red", Vector2(game.arena.position.x + 120.0, game.arena.position.y + 180.0), 0)
	game.balls[0].hp = 1
	game.balls[0].max_hp = 1
	game._spawn_target_ball("yellow", Vector2(game.arena.position.x + 260.0, game.arena.position.y + 180.0), 1)
	game.balls[1].hp = 1
	game.balls[1].max_hp = 1
	var freeze_rect: Rect2 = game.powerup_slots.get("freeze", Rect2())
	game._handle_powerup_press(freeze_rect.get_center())
	if not game.powerup_help_active or game.powerup_help_id != "freeze":
		failures.append("first freeze press should open help")
	if game.coin_count != 1000 or game.target_freeze_timer > 0.0:
		failures.append("help should not charge or activate before OK")
	game._handle_powerup_help_press(game.powerup_help_ok_rect.get_center())
	if game.powerup_help_active or not bool(game.powerup_help_seen.get("freeze", false)):
		failures.append("freeze OK should close help and mark seen")
	if game.coin_count != 1000 - game.FREEZE_COST or game.target_freeze_timer <= 0.0:
		failures.append("freeze OK should immediately charge and activate")

	game.target_freeze_timer = 0.0
	game.coin_count = 1000
	var red_bomb_rect: Rect2 = game.powerup_slots.get("bomb_red", Rect2())
	game._handle_powerup_press(red_bomb_rect.get_center())
	if not game.powerup_help_active or game.powerup_help_id != "bomb":
		failures.append("first bomb press should open shared bomb help")
	game._handle_powerup_help_press(game.powerup_help_ok_rect.get_center())
	if not bool(game.powerup_help_seen.get("bomb", false)):
		failures.append("bomb help should be marked seen")
	if game.coin_count != 1000 - game.COLOR_BOMB_COST:
		failures.append("bomb OK should charge immediately")
	game._step_pending_bombs(game.COLOR_BOMB_DELAY + 0.1)
	if game._target_count_for_color("red") != 0 or game._target_count_for_color("yellow") != 1:
		failures.append("bomb should damage/remove red only after the delay")
	if game.color_bomb_stock["red"] != 0:
		failures.append("bomb help OK should not create stored stock")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("POWERUP_HELP_DIRECT_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
