extends SceneTree

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.current_level = 8
	game._start_level()
	game._clear_level_intro()

	# Full-charge bonus: tension 1.0 fires 20% above LAUNCH_MAX_SPEED.
	if absf(game._launch_speed_for_tension(1.0) - game.LAUNCH_MAX_SPEED * game.FULL_CHARGE_SPEED_BONUS) > 0.01:
		failures.append("tension 1.0 should give a 20%% bonus, got %f" % game._launch_speed_for_tension(1.0))
	if absf(game._launch_speed_for_tension(0.9) - lerpf(game.LAUNCH_MIN_SPEED, game.LAUNCH_MAX_SPEED, 0.9)) > 0.01:
		failures.append("tension 0.9 must NOT get the bonus")
	if absf(game._launch_speed_for_tension(0.0) - game.LAUNCH_MIN_SPEED) > 0.01:
		failures.append("tension 0 should give LAUNCH_MIN_SPEED")

	# Player ball speed decays over time (drag).
	game.balls.clear()
	game._spawn_target_ball("red", game.arena.position + Vector2(60.0, 60.0), 0)
	game.balls[0].velocity = Vector2.ZERO
	game._spawn_launcher_ball("red", game.LAUNCH_MAX_SPEED, Vector2.UP)
	var player = game.balls[game.balls.size() - 1]
	player.position = game.arena.get_center()
	var speed_before: float = player.speed
	game._step_balls(0.5)
	if player.speed >= speed_before:
		failures.append("player ball speed should decay over time")

	# Wall bounce costs energy for player balls.
	var left_bound: float = game.arena.position.x + game.wall_tube_inset
	player.position = Vector2(left_bound + player.radius - 2.0, game.arena.get_center().y)
	player.velocity = Vector2(-player.speed, 0.0)
	speed_before = player.speed
	game._resolve_wall_collision(player)
	if absf(player.speed - speed_before * game.PLAYER_BALL_BOUNCE_RESTITUTION) > 0.01:
		failures.append("wall bounce should cost restitution, got %f of %f" % [player.speed, speed_before])

	# Drag alone never kills: a slow gliding ball stays alive.
	player.speed = game.PLAYER_BALL_MIN_ALIVE_SPEED - 1.0
	player.velocity = Vector2(0.0, -player.speed)
	player.position = game.arena.get_center()
	game._expire_spent_launcher_balls()
	var player_alive := false
	for ball in game.balls:
		if not ball.is_target and ball.special_kind == "":
			player_alive = true
	if not player_alive:
		failures.append("slow gliding ball must NOT die between collisions (balls=%d)" % game.balls.size())

	# A collision too weak to bounce kills the ball on the spot.
	player.position = Vector2(left_bound + player.radius - 2.0, game.arena.get_center().y)
	player.velocity = Vector2(-player.speed, 0.0)
	game._resolve_wall_collision(player)
	game._expire_spent_launcher_balls()
	player_alive = false
	for ball in game.balls:
		if not ball.is_target and ball.special_kind == "":
			player_alive = true
	if player_alive:
		failures.append("ball too slow to bounce should die at the collision")

	# Targets never decay: bounce keeps their speed.
	game.balls.clear()
	game._spawn_target_ball("red", game.arena.get_center(), 0)
	var target = game.balls[game.balls.size() - 1]
	var target_speed: float = target.speed
	game._step_balls(0.5)
	if absf(target.speed - target_speed) > 0.01:
		failures.append("target speed must not decay over time")
	target.position = Vector2(left_bound + target.radius - 2.0, game.arena.get_center().y)
	target.velocity = Vector2(-target.speed, 0.0)
	game._resolve_wall_collision(target)
	if absf(target.speed - target_speed) > 0.01:
		failures.append("target speed must not decay on wall bounce")

	# Specials keep constant speed (crystal exempt from drag and speed-death).
	game.balls.clear()
	game._spawn_special_ball("red", "crystal", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var crystal = game.balls[game.balls.size() - 1]
	crystal.position = game.arena.get_center()
	var crystal_speed: float = crystal.speed
	game._step_balls(0.5)
	if absf(crystal.speed - crystal_speed) > 0.01:
		failures.append("crystal speed must not decay")

	# Same-color hit on a SURVIVING multi-HP target bounces the player ball off.
	game.current_level = 12
	game._start_level()
	game._clear_level_intro()
	game.balls.clear()
	game._spawn_target_ball("red", game.arena.get_center(), 0)
	var hp_target = game.balls[0]
	hp_target.hp = 3
	hp_target.max_hp = 3
	hp_target.velocity = Vector2.ZERO
	game._spawn_launcher_ball("red", game.LAUNCH_MAX_SPEED, Vector2.UP)
	var striker = game.balls[game.balls.size() - 1]
	striker.position = hp_target.position + Vector2(hp_target.radius + striker.radius - 1.0, 0.0)
	striker.velocity = Vector2(-striker.speed, 0.0)
	game._resolve_ball_collisions()
	if hp_target.hp != 2:
		failures.append("surviving target should lose exactly 1 HP, has %d" % hp_target.hp)
	var striker_alive := false
	for ball in game.balls:
		if not ball.is_target and ball.special_kind == "":
			striker_alive = true
	if not striker_alive:
		failures.append("player ball must bounce off a surviving multi-HP target")
	if striker.collision_count != 1:
		failures.append("bounce-off should count one collision, got %d" % striker.collision_count)
	hp_target.hp = 1
	striker.position = hp_target.position + Vector2(hp_target.radius + striker.radius - 1.0, 0.0)
	striker.velocity = Vector2(-striker.speed, 0.0)
	game._resolve_ball_collisions()
	striker_alive = false
	for ball in game.balls:
		if not ball.is_target and ball.special_kind == "":
			striker_alive = true
	if striker_alive:
		failures.append("killing blow should consume the player ball")
	game.current_level = 8
	game._start_level()
	game._clear_level_intro()
	game.balls.clear()

	# Full-charge launch: burst overshoot then settle back to the bonus speed.
	game.balls.clear()
	game._spawn_target_ball("red", game.arena.position + Vector2(60.0, 60.0), 0)
	game.balls[0].velocity = Vector2.ZERO
	var bonus_speed: float = game._launch_speed_for_tension(1.0)
	game._spawn_launcher_ball("red", bonus_speed, Vector2.UP, true)
	var burst = game.balls[game.balls.size() - 1]
	if absf(burst.speed - bonus_speed * game.FULL_CHARGE_BURST_MULTIPLIER) > 0.01:
		failures.append("full-charge should launch at burst speed, got %f" % burst.speed)
	burst.position = game.arena.get_center()
	burst.velocity = Vector2(0.0, -burst.speed)
	var settle_steps := 0
	while burst.burst_settle_speed > 0.0 and settle_steps < 90:
		game._step_balls(0.016)
		burst.position = game.arena.get_center()
		settle_steps += 1
	if burst.burst_settle_speed > 0.0:
		failures.append("burst state should clear after settling")
	elif absf(burst.speed - bonus_speed) > 5.0:
		failures.append("at settle the speed should equal the bonus speed, got %f vs %f" % [burst.speed, bonus_speed])
	game._step_balls(0.5)
	burst.position = game.arena.get_center()
	if burst.speed >= bonus_speed:
		failures.append("normal drag should resume after the burst settles")

	# Charging loop: plays at full tension, stops when eased or drag cleared.
	var red_center: Vector2 = game._button_center("red")
	var max_pull: float = game.button_radius * game.MAX_PULL_RADIUS_MULTIPLIER
	game.drag_active = true
	game.drag_color = "red"
	game.drag_raw_position = red_center + Vector2(0.0, max_pull + 40.0)
	game.drag_position = game._drag_preview_position(game.drag_raw_position)
	game._update_charging_audio()
	if game.charging_player == null or not game.charging_player.playing:
		failures.append("charging loop should play at full tension")
	if not game.charging_player.stream.loop:
		failures.append("charging stream should loop")
	game.drag_raw_position = red_center + Vector2(0.0, max_pull * 0.4)
	game.drag_position = game._drag_preview_position(game.drag_raw_position)
	game._update_charging_audio()
	if game.charging_player.playing:
		failures.append("charging loop should stop below full tension")
	game.drag_raw_position = red_center + Vector2(0.0, max_pull + 40.0)
	game.drag_position = game._drag_preview_position(game.drag_raw_position)
	game._update_charging_audio()
	game._clear_drag()
	if game.charging_player.playing:
		failures.append("clearing the drag should stop the charging loop")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("BALL_PHYSICS_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
