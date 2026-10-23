extends SceneTree

func _touch(game, position: Vector2, pressed: bool, canceled: bool = false) -> void:
	var event := InputEventScreenTouch.new()
	event.position = position
	event.pressed = pressed
	event.canceled = canceled
	game._input(event)

func _drag(game, position: Vector2) -> void:
	var event := InputEventScreenDrag.new()
	event.position = position
	game._input(event)

func _start(game, level: int) -> void:
	game.current_level = level
	game._start_level()
	game._clear_level_intro()
	game.menu_active = false

func _init() -> void:
	root.size = Vector2i(540, 960)
	var game = load("res://scenes/main.tscn").instantiate()
	root.add_child(game)
	await process_frame
	game.set_process(false)
	var failures: Array[String] = []

	# An OS-canceled pull must not be interpreted as the player's release.
	for level in [1, 26]:
		_start(game, level)
		_touch(game, game._button_center("red"), true)
		var color := "red"
		if level == 26:
			color = "yellow"
			_drag(game, game._button_center(color))
			if not game.drag_mix_locked:
				failures.append("mixed-color test did not lock a mixture")
		var pull: Vector2 = game._button_center(color) + Vector2(0.0, game.button_radius * game.MAX_PULL_RADIUS_MULTIPLIER * 0.7)
		_drag(game, pull)
		if not game.drag_active:
			failures.append("level %d: test pull did not start" % level)
		var before: int = game.shots_used
		_touch(game, pull, false, true)
		if game.shots_used != before:
			failures.append("level %d: canceled touch consumed a shot" % level)
		if game.drag_active or game.drag_mix_locked:
			failures.append("level %d: canceled touch left drag state active" % level)

	# A canceled power-up tap must not spend coins or equip the aimer.
	_start(game, 2)
	game.coin_count = 1000
	game.aimer_charges = 0
	game.aimer_armed = false
	game.powerup_help_seen["aimer"] = true
	game._layout_powerup_slots()
	var slot: Vector2 = game.powerup_slots["aimer"].get_center()
	_touch(game, slot, true)
	if not game.powerup_touch_active:
		failures.append("power-up test tap did not start")
	_touch(game, slot, false, true)
	if game.coin_count != 1000 or game.aimer_armed or game.aimer_charges != 0:
		failures.append("canceled power-up touch bought or equipped the aimer")
	if game.powerup_touch_active:
		failures.append("canceled power-up touch left tap state active")

	# Genuine releases still fire and purchase normally after cancellation.
	_start(game, 1)
	var pull: Vector2 = game._button_center("red") + Vector2(0.0, game.button_radius * game.MAX_PULL_RADIUS_MULTIPLIER * 0.7)
	_touch(game, game._button_center("red"), true)
	_drag(game, pull)
	_touch(game, pull, false)
	if game.shots_used != 1:
		failures.append("normal touch release should fire exactly one shot")
	_start(game, 2)
	game.coin_count = 1000
	game.aimer_charges = 0
	game.aimer_armed = false
	game.last_powerup_press_id = ""
	game._layout_powerup_slots()
	slot = game.powerup_slots["aimer"].get_center()
	_touch(game, slot, true)
	_touch(game, slot, false)
	if game.coin_count != 1000 - game.AIMER_COST or not game.aimer_armed:
		failures.append("normal power-up release should buy and equip the aimer")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("TOUCH_CANCEL_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
