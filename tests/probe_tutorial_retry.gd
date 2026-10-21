extends SceneTree

# Regression probe for the level-1 tutorial lock reported 2026-07-12:
# after firing red and yellow, a missed (expired) yellow shot used to regress
# the tutorial step and hard-block the blue pull with "Pull yellow first".
# The fix: the order gate only applies to colors never launched this level;
# a miss re-enables its own color without locking the ones after it.

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.current_level = 1
	game._start_level()
	game._clear_level_intro()
	game.shot_limit = 99

	# Fresh level: red is the expected color; yellow/blue are order-locked.
	if not game._validate_launch_color("red"):
		failures.append("fresh level: red must be launchable")
	if game._validate_launch_color("blue"):
		failures.append("fresh level: blue must be order-locked before red")

	game._launch_color("red", 0.8)
	if not game.shots_fired["red"]:
		failures.append("red launch should mark shots_fired.red")
	if game.tutorial_step != 1:
		failures.append("after red the tutorial should expect yellow, step=%d" % game.tutorial_step)
	if game._validate_launch_color("blue"):
		failures.append("blue must stay order-locked before yellow is ever fired")

	game._launch_color("yellow", 0.8)
	if game.tutorial_step != 2:
		failures.append("after yellow the tutorial should expect blue, step=%d" % game.tutorial_step)
	if not game._validate_launch_color("blue"):
		failures.append("blue must be launchable after red+yellow fired")

	# Yellow shot misses: force its launcher ball over the collision limit.
	var yellow_ball = null
	for ball in game.balls:
		if not ball.is_target and ball.color_name == "yellow":
			yellow_ball = ball
	if yellow_ball == null:
		failures.append("yellow launcher ball not found")
	else:
		yellow_ball.collision_count = 1 << 20
		game._expire_spent_launcher_balls()
		if game.shots_fired["yellow"]:
			failures.append("expired yellow shot should re-enable yellow (retry)")

	# THE BUG: blue must remain launchable after the yellow miss.
	if not game._validate_launch_color("blue"):
		failures.append("REGRESSION: blue locked again after yellow miss")
	if not game._validate_launch_color("yellow"):
		failures.append("yellow retry must be allowed after its miss")
	if game.tutorial_step != 2:
		failures.append("yellow miss must not regress the tutorial step, step=%d" % game.tutorial_step)
	if game._validate_launch_color("red"):
		failures.append("red is in flight and must stay blocked (already fired)")

	# Blue launch works, and the yellow retry after it works too.
	var balls_before: int = game.balls.size()
	game._launch_color("blue", 0.8)
	if game.balls.size() != balls_before + 1:
		failures.append("blue launch should spawn a ball")
	if game.tutorial_step != game.COLOR_ORDER.size():
		failures.append("all colors fired: step should be %d, got %d" % [game.COLOR_ORDER.size(), game.tutorial_step])
	balls_before = game.balls.size()
	game._launch_color("yellow", 0.8)
	if game.balls.size() != balls_before + 1:
		failures.append("yellow retry launch should spawn a ball")
	if game.tutorial_step != game.COLOR_ORDER.size():
		failures.append("retry launch must not move the step past the colors, got %d" % game.tutorial_step)

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("TUTORIAL_RETRY_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
