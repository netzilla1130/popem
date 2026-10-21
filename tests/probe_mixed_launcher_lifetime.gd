extends SceneTree

func _launcher_colors(game) -> Array:
	var colors := []
	for ball in game.balls:
		if not ball.is_target:
			colors.append(ball.color_name)
	return colors

func _launcher_count(game) -> int:
	var count := 0
	for ball in game.balls:
		if not ball.is_target:
			count += 1
	return count

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
	game._spawn_target_ball("orange", Vector2(game.arena.position.x + 90.0, game.arena.position.y + 180.0), 0)
	game._spawn_mixing_launcher_ball("red", "orange", 777, 0.75, Vector2.RIGHT)
	game._spawn_mixing_launcher_ball("yellow", "orange", 777, 0.75, Vector2.LEFT)
	for ball in game.balls:
		if not ball.is_target:
			ball.position = Vector2(game.arena.position.x + 220.0, game.arena.position.y + 260.0)
	game._resolve_ball_collisions()
	var colors := _launcher_colors(game)
	if colors.size() != 1 or not colors.has("orange"):
		failures.append("same batch should produce one orange launcher, got %s" % [str(colors)])
	else:
		var mixed_launcher = null
		for ball in game.balls:
			if not ball.is_target:
				mixed_launcher = ball
		if game._launcher_collision_limit(mixed_launcher) != game.MIXED_LAUNCHER_COLLISIONS:
			failures.append("mixed launcher limit should be 20")
		mixed_launcher.collision_count = game.MIXED_LAUNCHER_COLLISIONS - 1
		game._expire_spent_launcher_balls()
		if _launcher_count(game) != 1:
			failures.append("mixed launcher expired before 20 collisions")
		mixed_launcher.collision_count = game.MIXED_LAUNCHER_COLLISIONS
		game._expire_spent_launcher_balls()
		if _launcher_count(game) != 0:
			failures.append("mixed launcher did not expire at 20 collisions")
	game.balls.clear()
	game._spawn_target_ball("red", Vector2(game.arena.position.x + 90.0, game.arena.position.y + 180.0), 0)
	game._spawn_launcher_ball("red", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var normal_launcher = game.balls[game.balls.size() - 1]
	if game._launcher_collision_limit(normal_launcher) != game.MAX_LAUNCHER_COLLISIONS:
		failures.append("normal launcher limit should stay 10")
	normal_launcher.collision_count = game.MAX_LAUNCHER_COLLISIONS
	game._expire_spent_launcher_balls()
	if _launcher_count(game) != 0:
		failures.append("normal launcher did not expire at 10 collisions")
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("MIXED_LAUNCHER_LIFETIME_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
