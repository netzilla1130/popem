extends SceneTree

func _init() -> void:
	var scene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	if absf(game.TARGET_SPEED_MULTIPLIER - 0.65) > 0.001:
		failures.append("TARGET_SPEED_MULTIPLIER should be 0.65, got %.2f" % game.TARGET_SPEED_MULTIPLIER)
	game.current_level = 2
	game._start_level()
	game._clear_level_intro()
	if game.shot_limit != int(game.LEVEL_SHOT_LIMITS[1]) + game.SHOT_LIMIT_BONUS:
		failures.append("level 2 shot limit expected base+bonus, got %d" % game.shot_limit)
	var min_speed: float = game.BASE_SPEED * game.TARGET_SPEED_MULTIPLIER
	var max_speed: float = min_speed * 3.0
	for ball in game.balls:
		if not ball.is_target:
			continue
		if ball.speed < min_speed - 0.01 or ball.speed > max_speed + 0.01:
			failures.append("target speed out of scaled range: %.2f" % ball.speed)
		var ratio: float = ball.speed / min_speed
		if absf(ratio - roundf(ratio)) > 0.01:
			failures.append("target speed is not scaled base multiple: %.2f" % ball.speed)
		if absf(ball.velocity.length() - ball.speed) > 0.01:
			failures.append("target velocity length mismatch")
	game.current_level = 30
	game._start_level()
	if game.shot_limit != int(game.LEVEL_SHOT_LIMITS[29]) + game.SHOT_LIMIT_BONUS:
		failures.append("level 30 shot limit expected base+bonus, got %d" % game.shot_limit)
	if absf(game.MERGED_TARGET_MIN_SPEED - game.BASE_SPEED * game.TARGET_SPEED_MULTIPLIER * 0.75) > 0.01:
		failures.append("merged min speed not scaled")
	if absf(game.MERGED_TARGET_MAX_SPEED - game.BASE_SPEED * game.TARGET_SPEED_MULTIPLIER * 1.35) > 0.01:
		failures.append("merged max speed not scaled")
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("TARGET_SPEED_SHOT_PLUS5_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
