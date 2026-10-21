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
	game.furball_shot_armed = false
	game.balls.clear()

	# merge two same-color targets -> spikes out
	var merge_pos := Vector2(game.arena.position.x + 200.0, game.arena.position.y + 240.0)
	game._spawn_target_ball("red", merge_pos, 0)
	game._spawn_target_ball("red", merge_pos + Vector2(1.0, 0.0), 1)
	game.balls[0].velocity = Vector2.RIGHT * game.BASE_SPEED
	game.balls[1].velocity = Vector2.LEFT * game.BASE_SPEED
	game._resolve_ball_collisions()
	if game.balls.size() != 1 or not game.balls[0].merged_target:
		failures.append("targets did not merge")
	var big = game.balls[0]
	if big.spike_state != "out" or big.spike_count != game.SPIKE_COUNT_MAX:
		failures.append("merged target should start with %d spikes out, got %s/%d" % [game.SPIKE_COUNT_MAX, big.spike_state, big.spike_count])
	if game._spike_extension(big) > 0.01:
		failures.append("spike extension should start at 0 (grow anim)")
	game._step_merged_target_spikes(0.15)
	if game._spike_extension(big) <= 0.1:
		failures.append("spike extension should grow after a step")

	# normal matching-color ball hits spiked target -> ball dies, spike -1, target hp unchanged
	big.hp = 5
	big.max_hp = 5
	big.position = merge_pos
	big.velocity = Vector2.ZERO
	game._spawn_launcher_ball("red", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var shot = game.balls[game.balls.size() - 1]
	shot.position = merge_pos + Vector2(big.radius + shot.radius - 1.0, 0.0)
	game._resolve_ball_collisions()
	if big.spike_count != game.SPIKE_COUNT_MAX - 1:
		failures.append("spike count should drop to %d, got %d" % [game.SPIKE_COUNT_MAX - 1, big.spike_count])
	if big.hp != 5:
		failures.append("spiked target should take no damage, hp %d" % big.hp)
	var launcher_alive := false
	for ball in game.balls:
		if not ball.is_target:
			launcher_alive = true
	if launcher_alive:
		failures.append("launcher ball should explode on spikes")

	# cycle: out -> retract -> cooldown -> out with full spikes
	big.spike_timer = 0.01
	game._step_merged_target_spikes(0.02)
	if big.spike_state != "retract":
		failures.append("spikes should retract after out phase, got %s" % big.spike_state)
	game._step_merged_target_spikes(game.SPIKE_RETRACT_SECONDS + 0.01)
	if big.spike_state != "cooldown":
		failures.append("spikes should cool down after retract, got %s" % big.spike_state)
	if game._spike_extension(big) > 0.0:
		failures.append("extension should be 0 in cooldown")
	game._step_merged_target_spikes(game.SPIKE_COOLDOWN_SECONDS + 0.01)
	if big.spike_state != "out" or big.spike_count != game.SPIKE_COUNT_MAX:
		failures.append("spikes should regrow to full after cooldown, got %s/%d" % [big.spike_state, big.spike_count])

	# vulnerable during cooldown: matching ball pops normally
	big.spike_state = "cooldown"
	big.spike_timer = 5.0
	big.spike_count = 0
	big.hp = 1
	big.max_hp = 1
	game._spawn_launcher_ball("red", game.LAUNCH_MIN_SPEED, Vector2.UP)
	var shot2 = game.balls[game.balls.size() - 1]
	shot2.position = big.position + Vector2(big.radius + shot2.radius - 1.0, 0.0)
	game._resolve_ball_collisions()
	var big_alive := false
	for ball in game.balls:
		if ball.is_target and ball.merged_target:
			big_alive = true
	if big_alive:
		failures.append("cooldown target should be poppable")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("SPIKE_MECHANIC_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
