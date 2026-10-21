extends SceneTree

func _init() -> void:
	var scene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	var intro_levels := [1, 6, 11, 16, 21]
	for level in intro_levels:
		game.current_level = level
		game._start_level()
		if not game.level_intro_active:
			failures.append("level %d did not show intro" % level)
		if game.level_intro_ok_rect.size.x <= 0.0 or game.level_intro_ok_rect.size.y <= 0.0:
			failures.append("level %d intro ok rect missing" % level)
		var before_position: Vector2 = game.balls[0].position
		game._process(0.5)
		var after_position: Vector2 = game.balls[0].position
		if before_position.distance_to(after_position) > 0.01:
			failures.append("level %d moved while intro active" % level)
		game._handle_level_intro_press(game.level_intro_ok_rect.position + game.level_intro_ok_rect.size * 0.5)
		if game.level_intro_active:
			failures.append("level %d intro did not close on OK" % level)
	var plain_levels := [2, 7, 12, 17, 22]
	for level in plain_levels:
		game.current_level = level
		game._start_level()
		if game.level_intro_active:
			failures.append("level %d unexpectedly showed intro" % level)
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("INTRO_DIALOG_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
