extends SceneTree

func _launcher_balls(game) -> Array:
	var launchers := []
	for ball in game.balls:
		if not ball.is_target:
			launchers.append(ball)
	return launchers

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
	game.balls.clear()
	game._spawn_target_ball("red", Vector2(game.arena.position.x + 110.0, game.arena.position.y + 180.0), 0)
	game.missile_stock = 1
	game.armed_special_kind = "missile"
	var red_release = game._button_center("red") + Vector2(0.0, game.button_radius * 2.2)
	game._begin_mix_touch(0, game._button_center("red"))
	game._release_mix_touch(0, red_release)
	var single_launchers := _launcher_balls(game)
	if single_launchers.size() != 1 or single_launchers[0].special_kind != "missile" or single_launchers[0].color_name != "red":
		failures.append("single touch should still fire a red missile")
	if game.missile_stock != 1 or game.shots_used != 1:
		failures.append("single missile fallback should ignore stock and use one shot")
	game.balls.clear()
	game.shots_used = 0
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 110.0, game.arena.position.y + 180.0), 0)
	game.missile_stock = 1
	game.armed_special_kind = "missile"
	if not game._can_use_mix_touch_input():
		failures.append("armed missile should allow mix touch input")
	_start_mixed_launch(game, "red", "yellow")
	var pending := _launcher_balls(game)
	if game.missile_stock != 1 or game.armed_special_kind != "" or game.shots_used != 1:
		failures.append("mixed missile launch should ignore stock and use one shot")
	if pending.size() != 2:
		failures.append("expected two pending base launchers, got %d" % pending.size())
	else:
		for ball in pending:
			if ball.special_kind != "" or ball.mix_result_special_kind != "missile" or ball.mix_result_color != "orange":
				failures.append("pending mixed missile metadata wrong")
		pending[0].position = Vector2(game.arena.position.x + 220.0, game.arena.position.y + 260.0)
		pending[1].position = pending[0].position
		pending[0].velocity = Vector2.RIGHT * pending[0].speed
		pending[1].velocity = Vector2.LEFT * pending[1].speed
		game._resolve_ball_collisions()
		var launchers_after_mix := _launcher_balls(game)
		if launchers_after_mix.size() != 1:
			failures.append("expected one fused launcher after collision")
		else:
			var missile = launchers_after_mix[0]
			if missile.color_name != "orange" or missile.special_kind != "missile":
				failures.append("fused launcher should become orange missile")
			if missile.speed < game.MISSILE_START_SPEED - 0.01:
				failures.append("fused missile speed below missile start speed")
			missile.position = Vector2(game.arena.position.x + 300.0, game.arena.position.y + 180.0)
			missile.velocity = Vector2.RIGHT * missile.speed
			game._step_missile_tracking(missile)
			if missile.velocity.x >= 0.0:
				failures.append("orange missile did not turn toward orange target")
	game.balls.clear()
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 110.0, game.arena.position.y + 180.0), 0)
	game.missile_stock = 1
	game.armed_special_kind = "missile"
	game.shots_used = 0
	_start_mixed_launch(game, "yellow", "blue")
	if game.missile_stock != 1 or game.shots_used != 0 or _launcher_balls(game).size() != 0:
		failures.append("mixed missile should not fire without matching mixed target")
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("MISSILE_MIXED_LAUNCHER_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
