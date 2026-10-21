extends SceneTree

func _targets_by_color(game, color_name: String) -> Array:
	var found := []
	for ball in game.balls:
		if ball.is_target and ball.color_name == color_name:
			found.append(ball)
	return found

func _missiles(game) -> Array:
	var found := []
	for ball in game.balls:
		if not ball.is_target and ball.special_kind == "missile":
			found.append(ball)
	return found

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.current_level = 11
	game._start_level()
	game._clear_level_intro()
	game.balls.clear()
	game._spawn_target_ball("red", Vector2(game.arena.position.x + 280.0, game.arena.position.y + 240.0), 0)
	game.balls[0].hp = 2
	game.balls[0].max_hp = 2
	game.armed_special_kind = "missile"
	game._launch_armed_special("blue", 0.5, Vector2.UP)
	if game.shots_used != 0 or _missiles(game).size() != 0 or game.armed_special_kind != "missile":
		failures.append("missile should stay armed when selected color has no target")
	game._launch_armed_special("red", 0.5, Vector2.LEFT)
	var launched := _missiles(game)
	if launched.size() != 1:
		failures.append("expected one launched missile, got %d" % launched.size())
	else:
		var missile = launched[0]
		if missile.color_name != "red" or game.armed_special_kind != "" or game.shots_used != 1:
			failures.append("missile launch should use armed state and one shot")
		missile.position = Vector2(game.arena.position.x + 120.0, game.arena.position.y + 240.0)
		missile.velocity = Vector2.LEFT * missile.speed
		game._step_missile_tracking(missile)
		if missile.velocity.x <= 0.0:
			failures.append("missile did not turn toward red target")

	game.current_level = 21
	game.balls.clear()
	var impact_pos := Vector2(game.arena.position.x + 220.0, game.arena.position.y + 260.0)
	game._spawn_target_ball("red", impact_pos, 0)
	var direct = game.balls[0]
	direct.hp = 2
	direct.max_hp = 2
	direct.merged_target = true
	direct.radius = game.TARGET_RADIUS * game.MERGED_TARGET_RADIUS_MULTIPLIER
	direct.spike_state = "out"
	direct.spike_timer = game.SPIKE_OUT_SECONDS
	direct.spike_count = game.SPIKE_COUNT_MAX
	game._spawn_target_ball("yellow", impact_pos + Vector2(game.MISSILE_BLAST_RADIUS - 4.0, 0.0), 1)
	game.balls[1].hp = 2
	game.balls[1].max_hp = 2
	game._spawn_target_ball("blue", impact_pos + Vector2(0.0, game.MISSILE_BLAST_RADIUS - 4.0), 2)
	game.balls[2].hp = 1
	game.balls[2].max_hp = 1
	game._spawn_target_ball("red", impact_pos + Vector2(game.MISSILE_BLAST_RADIUS + 80.0, 0.0), 3)
	var far_red = game.balls[3]
	far_red.hp = 2
	far_red.max_hp = 2
	game._spawn_special_ball("red", "missile", game.LAUNCH_MIN_SPEED, Vector2.RIGHT)
	var missile2 = game.balls[game.balls.size() - 1]
	missile2.position = impact_pos - Vector2(direct.radius + missile2.radius - 1.0, 0.0)
	game._resolve_ball_collisions()
	if _targets_by_color(game, "yellow").size() != 1 or _targets_by_color(game, "yellow")[0].hp != 1:
		failures.append("splash 2HP target should remain at 1HP")
	if _targets_by_color(game, "blue").size() != 0:
		failures.append("splash 1HP target should be removed")
	var red_targets := _targets_by_color(game, "red")
	if red_targets.size() != 1 or red_targets[0] != far_red or far_red.hp != 2:
		failures.append("direct shielded red target should be destroyed and far red should remain")
	if _missiles(game).size() != 0:
		failures.append("missile should be consumed on impact")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("TRACKING_MISSILE_CURRENT_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
