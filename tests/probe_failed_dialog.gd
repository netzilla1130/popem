extends SceneTree

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array = []

	game.current_level = 5
	game.menu_active = false
	game._start_level()
	game._clear_level_intro()
	await process_frame

	# force out-of-shots
	game.coin_count = 99999
	game.shots_used = game.shot_limit
	for ball in game.balls.duplicate():
		if not ball.is_target:
			game.balls.erase(ball)
	game._check_level_failed()
	if not game.level_failed:
		failures.append("level_failed should be set when shots exhausted with targets left")
	if game.level_failed_dialog_rect.size.x <= 0.0 or game.level_failed_ok_rect.size.x <= 0.0:
		failures.append("failed dialog rects should be laid out when failed")

	# BUY path: affordable -> +3 shots, coins deducted, dialog cleared
	var cost: int = game._extra_shot_cost()
	var coins_before: int = game.coin_count
	var limit_before: int = game.shot_limit
	game._handle_failed_level_press()
	if game.level_failed:
		failures.append("buy path should clear level_failed")
	if game.shot_limit != limit_before + game.EXTRA_SHOTS_PER_BUY:
		failures.append("buy path should add EXTRA_SHOTS_PER_BUY shots")
	if game.coin_count != coins_before - cost:
		failures.append("buy path should deduct cost")
	if game.level_failed_dialog_rect.size.x > 0.0:
		failures.append("dialog rect should clear after buy")

	# RETRY path: broke -> level restarts
	game.coin_count = 0
	game.shots_used = game.shot_limit
	for ball in game.balls.duplicate():
		if not ball.is_target:
			game.balls.erase(ball)
	game._check_level_failed()
	if not game.level_failed:
		failures.append("level_failed should re-trigger")
	game._handle_failed_level_press()
	if game.level_failed:
		failures.append("retry path should clear level_failed")
	if game.shots_used != 0:
		failures.append("retry path should restart level (shots_used reset)")

	# clean shared save
	game.coin_count = 0
	game._save_progress(1)

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("FAILED_DIALOG_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
