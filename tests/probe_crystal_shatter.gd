extends SceneTree

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.current_level = 21
	game._start_level()
	game._clear_level_intro()

	# Cost 400; spawns with 15 impacts and 1.5x radius.
	if game.CRYSTAL_BALL_COST != 400:
		failures.append("crystal cost should be 400, got %d" % game.CRYSTAL_BALL_COST)
	if game.CRYSTAL_BALL_HP != 15:
		failures.append("CRYSTAL_BALL_HP should be 15, got %d" % game.CRYSTAL_BALL_HP)
	game.balls.clear()
	game._spawn_special_ball("red", "crystal", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var crystal = game.balls[game.balls.size() - 1]
	if crystal.special_hp != 15:
		failures.append("crystal special_hp should start at 15, got %d" % crystal.special_hp)
	if absf(crystal.radius - game.LAUNCH_RADIUS * game.CRYSTAL_BALL_RADIUS_SCALE) > 0.001:
		failures.append("crystal radius should be 1.5x LAUNCH_RADIUS")

	# Side wall bounce costs 1 impact; floor bounce costs none.
	var left_bound: float = game.arena.position.x + game.wall_tube_inset
	crystal.position = Vector2(left_bound + crystal.radius - 2.0, game.arena.get_center().y)
	crystal.velocity = Vector2(-100.0, 0.0)
	game._resolve_wall_collision(crystal)
	if crystal.special_hp != 14:
		failures.append("side wall bounce should cost 1 impact, hp now %d" % crystal.special_hp)
	crystal.position = Vector2(game.arena.get_center().x, game.arena.end.y - crystal.radius + 2.0)
	crystal.velocity = Vector2(0.0, 100.0)
	game._resolve_wall_collision(crystal)
	if crystal.special_hp != 14:
		failures.append("floor bounce must NOT cost an impact, hp now %d" % crystal.special_hp)

	# Spiked big target: crystal knocks off ONE spike, survives, pays 1 impact.
	game._spawn_target_ball("blue", game.arena.get_center(), 1)
	var big = game.balls[game.balls.size() - 1]
	big.merged_target = true
	big.radius = game.TARGET_RADIUS * game.MERGED_TARGET_RADIUS_MULTIPLIER
	big.hp = 2
	big.max_hp = 2
	big.spike_state = "out"
	big.spike_timer = 5.0
	big.spike_count = 6
	big.velocity = Vector2.ZERO
	crystal.position = big.position + Vector2(big.radius + crystal.radius - 1.0, 0.0)
	crystal.velocity = Vector2(-50.0, 0.0)
	game._resolve_ball_collisions()
	if big.spike_count != 5:
		failures.append("spiked target should lose one spike, has %d" % big.spike_count)
	var crystal_alive := false
	for ball in game.balls:
		if ball.special_kind == "crystal":
			crystal_alive = true
	if not crystal_alive:
		failures.append("crystal must survive the spike hit")
	if crystal.special_hp != 13:
		failures.append("spike hit should cost 1 impact, hp now %d" % crystal.special_hp)

	# Plain target hit: target loses 1 HP, crystal survives and pays 1 impact.
	big.spike_state = ""
	big.spike_count = 0
	crystal.position = big.position + Vector2(big.radius + crystal.radius - 1.0, 0.0)
	crystal.velocity = Vector2(-50.0, 0.0)
	game._resolve_ball_collisions()
	if big.hp != 1:
		failures.append("target should lose 1 HP, has %d" % big.hp)
	if crystal.special_hp != 12:
		failures.append("target hit should cost 1 impact, hp now %d" % crystal.special_hp)

	# Death by last impact on a target: shatter + glass sfx fire on the collision path.
	crystal.special_hp = 1
	var particles_before: int = game.particles.size()
	crystal.position = big.position + Vector2(big.radius + crystal.radius - 1.0, 0.0)
	game._resolve_ball_collisions()
	crystal_alive = false
	for ball in game.balls:
		if ball.special_kind == "crystal":
			crystal_alive = true
	if crystal_alive:
		failures.append("crystal at 0 impacts should be removed")
	if game.particles.size() <= particles_before:
		failures.append("shatter should spawn shard particles")
	if game.sfx_player.stream != game.SFX_GLASS_SHATTER_STREAM:
		failures.append("shatter should play the glass sfx")

	# Generic collision limit must NOT kill a crystal early.
	game.balls.clear()
	game._spawn_special_ball("red", "crystal", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var crystal2 = game.balls[game.balls.size() - 1]
	crystal2.collision_count = 999
	game._expire_spent_launcher_balls()
	crystal_alive = false
	for ball in game.balls:
		if ball.special_kind == "crystal":
			crystal_alive = true
	if not crystal_alive:
		failures.append("crystal must not die from the generic collision limit")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("CRYSTAL_SHATTER_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
