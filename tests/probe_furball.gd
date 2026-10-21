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

	# purchase: pay 1200, arm ONE furball shot
	game.coin_count = 1500
	game.furball_shot_armed = false
	game.powerup_help_seen["furball"] = true
	game._activate_or_buy_furball()
	if game.coin_count != 300:
		failures.append("cost should be 1200, coins now %d" % game.coin_count)
	if not game.furball_shot_armed:
		failures.append("purchase should arm the furball shot")
	if game._powerup_needs_confirm("furball"):
		failures.append("card tap while armed should NOT open the buy dialog")

	# tap while armed never spends again
	game._activate_or_buy_furball()
	if game.coin_count != 300 or not game.furball_shot_armed:
		failures.append("tap while armed should be a no-op")

	# insufficient funds
	game.furball_shot_armed = false
	game.coin_count = 100
	if not game._powerup_needs_confirm("furball"):
		failures.append("card tap unarmed with no live furball should open the buy dialog")
	game._activate_or_buy_furball()
	if game.furball_shot_armed or game.coin_count != 100:
		failures.append("purchase without funds should fail")

	# unarmed launches stay normal
	game.balls.clear()
	game._spawn_target_ball("blue", game.arena.get_center() + Vector2(200.0, 0.0), 0)
	game._spawn_launcher_ball("red", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var normal_ball = game.balls[game.balls.size() - 1]
	if normal_ball.is_furball:
		failures.append("unarmed launch should not convert")

	# armed launch converts ONE shot: big ball, meow starts, arm consumed
	game.furball_shot_armed = true
	game._spawn_launcher_ball("red", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var fb = game.balls[game.balls.size() - 1]
	if not fb.is_furball:
		failures.append("armed launch should convert to furball")
	if absf(fb.radius - game.LAUNCH_RADIUS * game.PINK_FURBALL_RADIUS_SCALE) > 0.001:
		failures.append("furball radius should be 1.5x LAUNCH_RADIUS")
	if game.furball_shot_armed:
		failures.append("launch should consume the armed shot")
	if fb.furball_life >= 0.0:
		failures.append("fuse should NOT start before the first target hit")
	if game.meow_player == null or not game.meow_player.playing:
		failures.append("launch should start the meow loop")
	if not game.meow_player.stream.loop:
		failures.append("meow stream should be set to loop")
	game._spawn_launcher_ball("yellow", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var second = game.balls[game.balls.size() - 1]
	if second.is_furball:
		failures.append("only ONE shot converts per purchase")
	game.balls.erase(second)

	# buy blocked while a furball is alive
	game.coin_count = 5000
	if game._powerup_needs_confirm("furball"):
		failures.append("live furball should suppress the buy dialog")
	game._activate_or_buy_furball()
	if game.coin_count != 5000 or game.furball_shot_armed:
		failures.append("buying while a furball is alive should be refused")

	# first target hit starts the 10s fuse
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
	fb.position = big.position + Vector2(big.radius + fb.radius - 1.0, 0.0)
	game._resolve_ball_collisions()
	var big_alive := false
	for ball in game.balls:
		if ball.is_target and ball.merged_target:
			big_alive = true
	if big_alive:
		failures.append("furball should destroy spiked merged target")
	if absf(fb.furball_life - game.PINK_FURBALL_LIFETIME) > 0.001:
		failures.append("first target hit should start the %ss fuse, got %s" % [game.PINK_FURBALL_LIFETIME, fb.furball_life])

	# destroys black hole and survives
	game.black_hole_enabled = true
	game.black_hole_active = true
	game.black_hole_position = fb.position
	game._resolve_black_hole_collisions()
	if game.black_hole_active:
		failures.append("furball should destroy black hole")

	# no impact-based death: absurd collision counts never expire it
	fb.collision_count = 999
	game._expire_spent_launcher_balls()
	var fb_alive := false
	for ball in game.balls:
		if not ball.is_target and ball.is_furball:
			fb_alive = true
	if not fb_alive:
		failures.append("furball must not die from impact count")

	# board clear + fuse running: level completion must WAIT
	for index in range(game.balls.size() - 1, -1, -1):
		if game.balls[index].is_target:
			game.balls.remove_at(index)
	fb.furball_life = 2.0
	game._check_level_complete()
	if game.level_complete_pending or game.level_complete:
		failures.append("completion must wait while the furball is alive")

	# fuse runs out: pink smoke burst >=1.5s particles, ball gone, meow stops, completion fires
	var particles_before: int = game.particles.size()
	game._step_furball_lifetimes(2.5)
	fb_alive = false
	for ball in game.balls:
		if not ball.is_target and ball.is_furball:
			fb_alive = true
	if fb_alive:
		failures.append("furball should explode when the fuse runs out")
	if game.particles.size() <= particles_before:
		failures.append("explosion should spawn smoke particles")
	var long_smoke := 0
	for particle in game.particles:
		if particle.kind == "puff" and particle.max_life >= 1.5:
			long_smoke += 1
	if long_smoke < 20:
		failures.append("smoke should linger >=1.5s (long puffs found: %d)" % long_smoke)
	if game.meow_player.playing:
		failures.append("meow should stop when the furball explodes")
	if not game.level_complete_pending and not game.level_complete:
		failures.append("completion should fire after the furball explodes on a clear board")

	# level reset silences the meow
	game.meow_player.play()
	game._start_level()
	if game.meow_player.playing:
		failures.append("level reset should stop the meow")

	# clean shared save
	game.furball_shot_armed = false
	game._save_progress(game.current_level)

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("FURBALL_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
