extends SceneTree

func _touch_at(position: Vector2) -> InputEventScreenTouch:
	var touch := InputEventScreenTouch.new()
	touch.pressed = true
	touch.position = position
	return touch

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	var saved_level: int = game.current_level
	var saved_coins: int = game.coin_count
	var saved_language: String = game.settings_language
	# Non-final level: tap after complete advances, no trial dialog.
	game.current_level = 5
	game.menu_active = false
	game._start_level()
	game._clear_level_intro()
	game.level_complete = true
	game._start_level_complete_panel()
	game._input(_touch_at(game.get_viewport_rect().size * 0.5))
	if game.trial_end_active:
		failures.append("trial dialog appeared on level 5")
	if game.current_level != 6:
		failures.append("level 5 tap did not advance (level=%d)" % game.current_level)
	# Final level: tap opens the trial-end dialog instead of replaying.
	game.current_level = game.LEVEL_TARGET_COUNTS.size()
	game._start_level()
	game._clear_level_intro()
	game.level_complete = true
	game._start_level_complete_panel()
	game._input(_touch_at(game.get_viewport_rect().size * 0.5))
	if not game.trial_end_active:
		failures.append("trial dialog missing after final level tap")
	if game.sfx_player.stream != game.SFX_DEMO_COMPLETE_STREAM:
		failures.append("demo-complete sfx stream not set on dialog open")
	if not game.sfx_player.playing:
		failures.append("demo-complete sfx not playing on dialog open")
	if game.trial_end_ok_rect.size.x <= 0.0 or game.trial_end_ok_rect.size.y <= 0.0:
		failures.append("trial ok rect missing")
	if game.menu_active:
		failures.append("menu opened before OK press")
	# Tap inside the dialog but off the OK button: dialog stays.
	game._input(_touch_at(game.trial_end_dialog_rect.get_center()))
	if not game.trial_end_active:
		failures.append("dialog closed on non-OK tap")
	# OK press returns to the start menu at level 1.
	game._input(_touch_at(game.trial_end_ok_rect.get_center()))
	if game.trial_end_active:
		failures.append("dialog did not close on OK")
	if not game.menu_active:
		failures.append("OK did not return to start menu")
	if game.current_level != 1:
		failures.append("OK did not reset level to 1 (level=%d)" % game.current_level)
	# zh strings exist for the new keys.
	game.settings_language = "zh"
	for key in ["You've cleared the POP'EM! demo. Thank you for playing!", "The full version is coming soon. Stay tuned!", "DEMO COMPLETE!", "TAP TO CONTINUE"]:
		if game._t(key) == key:
			failures.append("zh translation missing for '%s'" % key)
	# Restore the shared save.
	game.settings_language = saved_language
	game.current_level = saved_level
	game.coin_count = saved_coins
	game._save_progress(saved_level)
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("TRIAL_END_DIALOG_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
