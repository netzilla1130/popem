extends SceneTree

func _touch(game, index: int, position: Vector2, pressed: bool, canceled: bool = false) -> void:
	var event := InputEventScreenTouch.new()
	event.index = index
	event.position = position
	event.pressed = pressed
	event.canceled = canceled
	game._input(event)

func _drag(game, index: int, position: Vector2) -> void:
	var event := InputEventScreenDrag.new()
	event.index = index
	event.position = position
	game._input(event)

func _start(game, level: int) -> void:
	game.current_level = level
	game._start_level()
	game._clear_level_intro()

func _mouse(game, position: Vector2, pressed: bool, emulated: bool = false) -> void:
	var event := InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_LEFT
	event.position = position
	event.pressed = pressed
	if emulated:
		event.device = InputEvent.DEVICE_ID_EMULATION
	game._input(event)

func _init() -> void:
	root.size = Vector2i(540, 960)
	var game = load("res://scenes/main.tscn").instantiate()
	root.add_child(game)
	await process_frame
	game.set_process(false)
	var failures: Array[String] = []

	# An incidental second finger must not aim, fire, or cancel the held shot.
	for level in [1, 26]:
		for interruption in ["release", "cancel"]:
			_start(game, level)
			_touch(game, 3, game._button_center("red"), true)
			var color := "red"
			if level == 26:
				color = "yellow"
				_drag(game, 3, game._button_center(color))
			var pull: Vector2 = game._button_center(color) + Vector2(0.0, game.button_radius * game.MAX_PULL_RADIUS_MULTIPLIER * 0.7)
			_drag(game, 3, pull)
			var held_position: Vector2 = game.drag_raw_position
			var held_color: String = game.drag_color
			_touch(game, 7, game._button_center("blue"), true)
			_drag(game, 7, pull + Vector2(30.0, 0.0))
			if game.drag_raw_position != held_position or game.drag_color != held_color:
				failures.append("level %d: second finger changed the held aim/color" % level)
			_touch(game, 7, pull, false, interruption == "cancel")
			if game.shots_used != 0 or not game.drag_active:
				failures.append("level %d: second finger %s ended the held shot" % [level, interruption])
			_touch(game, 3, pull, false)
			if game.shots_used != 1 or game.drag_active:
				failures.append("level %d: owning finger should release exactly one shot" % level)
			var expected := "orange" if level == 26 else "red"
			for ball in game.balls:
				if not ball.is_target and ball.color_name != expected:
					failures.append("level %d: owning finger shot used the wrong color" % level)

	# Only the finger that pressed a power-up can complete its purchase.
	_start(game, 2)
	game.coin_count = 1000
	game.aimer_charges = 0
	game.aimer_armed = false
	game.powerup_help_seen["aimer"] = true
	game._layout_powerup_slots()
	var slot: Vector2 = game.powerup_slots["aimer"].get_center()
	_touch(game, 3, slot, true)
	_touch(game, 7, slot, true)
	_touch(game, 7, slot, false)
	if game.coin_count != 1000 or game.aimer_armed or not game.powerup_touch_active:
		failures.append("second finger completed or interrupted the power-up purchase")
	_touch(game, 3, slot, false)
	if game.coin_count != 1000 - game.AIMER_COST or not game.aimer_armed:
		failures.append("owning finger should still complete the power-up purchase")

	# Cancellation frees ownership for a new finger, including a nonzero index.
	_start(game, 1)
	var pull: Vector2 = game._button_center("red") + Vector2(0.0, game.button_radius * game.MAX_PULL_RADIUS_MULTIPLIER * 0.7)
	_touch(game, 3, game._button_center("red"), true)
	_drag(game, 3, pull)
	_touch(game, 3, pull, false, true)
	_touch(game, 7, game._button_center("red"), true)
	_drag(game, 7, pull)
	_touch(game, 7, pull, false)
	if game.shots_used != 1 or game.drag_active:
		failures.append("a new finger should work after the owning finger is canceled")

	# Synthesized mouse events cannot bypass ownership; a real mouse still fires.
	_start(game, 1)
	_touch(game, 3, game._button_center("red"), true)
	_drag(game, 3, pull)
	_mouse(game, pull, false, true)
	if game.shots_used != 0 or not game.drag_active:
		failures.append("an emulated mouse release ended the held touch")
	_touch(game, 3, pull, false)
	_touch(game, 7, pull, false)
	if game.shots_used != 1 or game.drag_active:
		failures.append("late non-owning release should not add another shot")
	_start(game, 1)
	_mouse(game, game._button_center("red"), true)
	_mouse(game, pull, false)
	if game.shots_used != 1 or game.drag_active:
		failures.append("normal mouse input should still fire")

	# Leaving a held gesture through the menu must not lock out later touches.
	_start(game, 1)
	_touch(game, 3, game._button_center("red"), true)
	game._return_to_start_menu()
	_touch(game, 7, game.start_menu_buttons["restart"].get_center(), true)
	game._clear_level_intro()
	_touch(game, 7, game._button_center("red"), true)
	_drag(game, 7, pull)
	_touch(game, 7, pull, false)
	if game.menu_active or game.shots_used != 1:
		failures.append("returning to the menu should free touch ownership")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("TOUCH_OWNERSHIP_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
