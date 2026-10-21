extends SceneTree

func _target_colors(game) -> Array:
	var colors := []
	for ball in game.balls:
		if ball.is_target:
			colors.append(ball.color_name)
	return colors

func _launcher_colors(game) -> Array:
	var colors := []
	for ball in game.balls:
		if not ball.is_target:
			colors.append(ball.color_name)
	return colors

func _init() -> void:
	var scene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	if game.LEVEL_TARGET_COUNTS.size() != 30 or game.LEVEL_SHOT_LIMITS.size() != 30:
		failures.append("level arrays are not length 30")
	game.current_level = 26
	game._start_level()
	if not game.level_intro_active:
		failures.append("level 26 intro missing")
	var colors26 := _target_colors(game)
	if colors26.size() != 6 or not colors26.has("orange") or not colors26.has("green") or not colors26.has("purple"):
		failures.append("level 26 target colors %s" % [str(colors26)])
	if game._level_has_black_holes():
		failures.append("level 26 should not have black holes")
	game.current_level = 28
	game._start_level()
	if game._level_has_black_holes():
		failures.append("level 28 should not have black holes")
	game.current_level = 29
	game._start_level()
	if not game._level_has_black_holes():
		failures.append("level 29 should have black holes")
	game.current_level = 30
	game._start_level()
	if game._target_count_for_color("orange") <= 0 or game._target_count_for_color("green") <= 0 or game._target_count_for_color("purple") <= 0:
		failures.append("level 30 missing mixed target colors")
	game.current_level = 26
	game._start_level()
	game._clear_level_intro()
	var red_release = game._button_center("red") + Vector2(0.0, game.button_radius * 2.2)
	var yellow_release = game._button_center("yellow") + Vector2(0.0, game.button_radius * 2.2)
	game._begin_mix_touch(0, game._button_center("red"))
	game._begin_mix_touch(1, game._button_center("yellow"))
	game._release_mix_touch(0, red_release)
	game._release_mix_touch(1, yellow_release)
	if game.shots_used != 1:
		failures.append("mixed launch should count one shot, got %d" % game.shots_used)
	var pending := []
	for ball in game.balls:
		if not ball.is_target and ball.mix_batch_id > 0:
			pending.append(ball)
	if pending.size() != 2:
		failures.append("expected two pending mix balls, got %d" % pending.size())
	else:
		pending[0].position = Vector2(game.arena.position.x + 160.0, game.arena.position.y + 220.0)
		pending[1].position = pending[0].position
		pending[0].velocity = Vector2.RIGHT * pending[0].speed
		pending[1].velocity = Vector2.LEFT * pending[1].speed
		game._resolve_ball_collisions()
		var launcher_colors := _launcher_colors(game)
		if not launcher_colors.has("orange"):
			failures.append("same batch red/yellow did not mix: %s" % [str(launcher_colors)])
	game.balls.clear()
	game._spawn_mixing_launcher_ball("red", "orange", 100, 0.8, Vector2.RIGHT)
	game._spawn_mixing_launcher_ball("yellow", "orange", 101, 0.8, Vector2.LEFT)
	for ball in game.balls:
		ball.position = Vector2(game.arena.position.x + 180.0, game.arena.position.y + 260.0)
	game._resolve_ball_collisions()
	var different_batch_colors := _launcher_colors(game)
	if different_batch_colors.size() != 2 or different_batch_colors.has("orange"):
		failures.append("different batches should not mix: %s" % [str(different_batch_colors)])
	game.balls.clear()
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 80.0, game.arena.position.y + 180.0), 0)
	var mixed_target = game.balls[0]
	game._recolor_ball_from_wall(mixed_target, "red")
	if mixed_target.color_name != "orange":
		failures.append("mixed target recolored on wall to %s" % mixed_target.color_name)
	game.balls.clear()
	game.current_level = 28
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 180.0, game.arena.position.y + 220.0), 0)
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 180.0, game.arena.position.y + 220.0), 1)
	game._resolve_ball_collisions()
	if game.balls.size() != 1 or not game.balls[0].merged_target or absf(game.balls[0].radius - game.TARGET_RADIUS * game.MERGED_TARGET_RADIUS_MULTIPLIER) > 0.01:
		failures.append("same mixed targets did not become big")
	game.balls.clear()
	game.current_level = 26
	game._spawn_target_ball("red", Vector2(game.arena.position.x + 210.0, game.arena.position.y + 220.0), 0)
	game._spawn_target_ball("yellow", Vector2(game.arena.position.x + 210.0, game.arena.position.y + 220.0), 1)
	game._resolve_ball_collisions()
	if game.balls.size() != 1 or game.balls[0].color_name != "orange":
		failures.append("red/yellow target fusion failed")
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("COLOR_MIX_26_30_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
