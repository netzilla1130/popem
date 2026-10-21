extends SceneTree

func _launcher_balls(game) -> Array:
	var launchers := []
	for ball in game.balls:
		if not ball.is_target:
			launchers.append(ball)
	return launchers

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array = []
	game.current_level = 16
	game.menu_active = false
	game._start_level()
	game._clear_level_intro()

	game.black_hole_enabled = true
	game.black_hole_active = true
	game.black_hole_position = game.arena.position + game.arena.size * 0.5

	# touch edge -> captured, not instantly removed
	game._spawn_launcher_ball("red", 400.0, Vector2.UP)
	var ball = game.balls[game.balls.size() - 1]
	var base_radius: float = ball.radius
	ball.position = game.black_hole_position + Vector2(game.BLACK_HOLE_RADIUS + ball.radius - 2.0, 0.0)
	game._resolve_black_hole_collisions()
	if ball.swallow_timer < 0.0:
		failures.append("touching black hole edge should start swallow")
	if not _launcher_balls(game).has(ball):
		failures.append("swallowed ball should remain during animation")

	# phase 1: shrinks toward 0.6 and gets pulled toward center
	var start_distance: float = ball.position.distance_to(game.black_hole_position)
	game._step_swallowed_balls(0.1)
	if not (ball.radius < base_radius and ball.radius > base_radius * 0.6):
		failures.append("phase-1 radius should be between 0.6x and 1x, got %f of base" % (ball.radius / base_radius))
	if ball.position.distance_to(game.black_hole_position) >= start_distance:
		failures.append("swallowed ball should be dragged toward the center")

	# phase 2: down toward 0.2
	game._step_swallowed_balls(0.2)
	if not (ball.radius <= base_radius * 0.62 and ball.radius >= base_radius * 0.18):
		failures.append("phase-2 radius should head to 0.2x, got %f of base" % (ball.radius / base_radius))

	# end: removed
	game._step_swallowed_balls(0.2)
	if _launcher_balls(game).has(ball):
		failures.append("ball should vanish after swallow animation")

	# regression: antimatter still destroys the hole instantly
	game.black_hole_active = true
	game._spawn_special_ball("red", "antimatter", 400.0, Vector2.UP)
	var anti = game.balls[game.balls.size() - 1]
	anti.position = game.black_hole_position
	game._resolve_black_hole_collisions()
	if game.black_hole_active:
		failures.append("antimatter should still destroy the black hole")
	if _launcher_balls(game).has(anti):
		failures.append("antimatter should be consumed on hole destruction")

	game.coin_count = 0
	game._save_progress(1)
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("BLACK_HOLE_SWALLOW_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
