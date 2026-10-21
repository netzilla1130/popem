extends SceneTree

func _launcher_balls(game) -> Array:
	var launchers := []
	for ball in game.balls:
		if not ball.is_target:
			launchers.append(ball)
	return launchers

func _launcher_colors(game) -> Array:
	var colors := []
	for ball in _launcher_balls(game):
		colors.append(ball.color_name)
	return colors

func _start_mixed_launch(game, first_color: String, second_color: String) -> void:
	var first_release = game._button_center(first_color) + Vector2(0.0, game.button_radius * 2.2)
	var second_release = game._button_center(second_color) + Vector2(0.0, game.button_radius * 2.2)
	game._begin_mix_touch(0, game._button_center(first_color))
	game._begin_mix_touch(1, game._button_center(second_color))
	game._release_mix_touch(0, first_release)
	game._release_mix_touch(1, second_release)

func _init() -> void:
	var scene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.current_level = 26
	game._start_level()
	game._clear_level_intro()
	_start_mixed_launch(game, "red", "yellow")
	if game.shots_used != 1:
		failures.append("mixed launch should count one shot, got %d" % game.shots_used)
	if _launcher_balls(game).size() != 2:
		failures.append("expected two pending launchers immediately, got %d colors=%s" % [_launcher_balls(game).size(), str(_launcher_colors(game))])
	game._step_balls(0.016)
	var after_first_step := _launcher_balls(game)
	if after_first_step.size() != 2:
		failures.append("pending mixed launchers should survive cap enforcement, got %d colors=%s" % [after_first_step.size(), str(_launcher_colors(game))])
	else:
		var batch_id: int = int(after_first_step[0].mix_batch_id)
		if batch_id <= 0 or after_first_step[1].mix_batch_id != batch_id:
			failures.append("pending launchers lost shared mix batch")
		if after_first_step[0].mix_result_color != "orange" or after_first_step[1].mix_result_color != "orange":
			failures.append("pending launchers should commit to orange")
	game.balls.clear()
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 90.0, game.arena.position.y + 180.0), 0)
	game._spawn_mixing_launcher_ball("red", "orange", 777, 0.75, Vector2.RIGHT)
	game._spawn_mixing_launcher_ball("yellow", "orange", 777, 0.75, Vector2.LEFT)
	for ball in _launcher_balls(game):
		ball.position = Vector2(game.arena.position.x + 220.0, game.arena.position.y + 260.0)
	game._resolve_ball_collisions()
	var colors_after_manual_collision := _launcher_colors(game)
	if colors_after_manual_collision.size() != 1 or not colors_after_manual_collision.has("orange"):
		failures.append("same batch should mix after real collision, got %s" % [str(colors_after_manual_collision)])
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("MIX_LAUNCH_CAP_REGRESSION_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
