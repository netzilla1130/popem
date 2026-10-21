extends SceneTree

func _init() -> void:
	var scene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.settings_language = "en"
	var expected := ["Bulls' Eye", "Nice Shot", "Incredible", "Touchez", "Perfect"]
	if game.PERFECT_PRAISE_TEXTS.size() != expected.size():
		failures.append("praise text list size changed")
	for text in expected:
		if not game.PERFECT_PRAISE_TEXTS.has(text):
			failures.append("missing praise text %s" % text)
	if game.PERFECT_PRAISE_TEXTS.has("PERFECT"):
		failures.append("old all-caps PERFECT should not be in praise list")
	game._spawn_perfect_text(Vector2(220.0, 260.0), "red")
	if game.floating_texts.size() != 1:
		failures.append("expected one praise popup")
	else:
		var praise = game.floating_texts[0]
		var start_position: Vector2 = praise.label.position
		var start_scale: Vector2 = praise.label.scale
		if not bool(praise.popup):
			failures.append("praise text should use popup mode")
		if praise.velocity.length_squared() > 0.001:
			failures.append("praise popup should not float upward")
		if not game.PERFECT_PRAISE_TEXTS.has(praise.label.text):
			failures.append("praise text outside allowed list: %s" % praise.label.text)
		game._step_floating_texts(0.08)
		if praise.label.position.distance_to(start_position) > 0.01:
			failures.append("praise popup moved like floating text")
		if praise.label.scale.distance_to(start_scale) <= 0.01:
			failures.append("praise popup scale did not animate")
	game._clear_floating_texts()
	var expected_zh := ["夯", "漂亮", "帅", "牛", "厉害"]
	if game.PERFECT_PRAISE_TEXTS_ZH.size() != expected_zh.size():
		failures.append("zh praise text list size changed")
	for text in expected_zh:
		if not game.PERFECT_PRAISE_TEXTS_ZH.has(text):
			failures.append("missing zh praise text %s" % text)
	game.settings_language = "zh"
	game._spawn_perfect_text(Vector2(220.0, 260.0), "red")
	if game.floating_texts.size() != 1:
		failures.append("expected one zh praise popup")
	elif not game.PERFECT_PRAISE_TEXTS_ZH.has(game.floating_texts[0].label.text):
		failures.append("zh praise text outside allowed list: %s" % game.floating_texts[0].label.text)
	game.settings_language = "en"
	game._clear_floating_texts()
	game._spawn_hp_change_text("-1", Vector2(220.0, 260.0), Color.WHITE)
	if game.floating_texts.size() != 1:
		failures.append("expected one hp floating text")
	else:
		var hp_text = game.floating_texts[0]
		var hp_start_position: Vector2 = hp_text.label.position
		if bool(hp_text.popup):
			failures.append("hp text should not use popup mode")
		game._step_floating_texts(0.08)
		if hp_text.label.position.distance_to(hp_start_position) <= 0.01:
			failures.append("hp text should still float")
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("PERFECT_PRAISE_POPUP_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
