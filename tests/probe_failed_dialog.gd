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

	# A paid bomb must resolve even if the final flying shot expires first.
	game.set_process(false)
	for leave_blue_target in [false, true]:
		game.current_level = 5
		game._start_level()
		game._clear_level_intro()
		game.balls.clear()
		game._spawn_target_ball("red", game.arena.get_center(), 0)
		if leave_blue_target:
			game._spawn_target_ball("blue", game.arena.get_center() + Vector2(100.0, 0.0), 1)
		for target in game.balls:
			target.velocity = Vector2.ZERO
		game.shots_used = game.shot_limit - 1
		game.coin_count = 1000
		game.powerup_help_seen["bomb"] = true
		game.last_powerup_press_time = -1000.0
		game._launch_color("red", 0.55)
		var last_shot = game.balls[game.balls.size() - 1]
		if last_shot.is_target or game.shots_used != game.shot_limit:
			failures.append("bomb test must begin with the final shot in flight")
		game._handle_powerup_press(game.powerup_slots["bomb_red"].get_center())
		if not game.powerup_confirm_active:
			failures.append("bomb test must reach the purchase confirmation")
		game._handle_powerup_confirm_press(game.powerup_confirm_ok_rect.get_center())
		if game.pending_color_bombs.size() != 1 or game.coin_count != 1000 - game.COLOR_BOMB_COST:
			failures.append("confirmed bomb must be paid and queued exactly once")
		last_shot.collision_count = game._launcher_collision_limit(last_shot)
		game._process(game.COLOR_BOMB_DELAY * 0.25)
		if game._has_active_launcher_balls():
			failures.append("the final shot should have expired")
		if game.level_failed or game.level_complete or game.pending_color_bombs.size() != 1:
			failures.append("queued bomb must keep the board running after the final shot expires")
		game._process(game.COLOR_BOMB_DELAY)
		if not game.pending_color_bombs.is_empty() or game._target_count_for_color("red") != 0:
			failures.append("paid bomb must detonate without buying extra shots")
		if game.coin_count != 1000 - game.COLOR_BOMB_COST:
			failures.append("waiting for a bomb must not spend extra coins")
		if leave_blue_target:
			if not game.level_failed or game.level_complete_pending:
				failures.append("remaining targets must still trigger failure once bombs finish")
		else:
			game._process(game.LEVEL_COMPLETE_DELAY_SECONDS + 0.1)
			if not game.level_complete or game.level_failed:
				failures.append("a bomb clearing the final target must complete the level")

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
