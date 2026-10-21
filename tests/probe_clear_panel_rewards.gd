extends SceneTree

func _init() -> void:
	var scene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.coin_count = 100
	game.current_level = 2
	game._start_level()
	game.level_perfect_hits = 2
	game.shots_used = 3
	game.balls.clear()
	game._check_level_complete()
	if not game.level_complete_pending:
		failures.append("level complete not pending after last target")
	game._finalize_level_complete()
	if not game.level_complete:
		failures.append("level did not complete")
	if game.last_level_base_reward != 30:
		failures.append("base reward %d" % game.last_level_base_reward)
	if game.last_level_perfect_bonus != 11:
		failures.append("perfect bonus %d" % game.last_level_perfect_bonus)
	if game.last_level_remaining_shots != 9:
		failures.append("remaining shots %d" % game.last_level_remaining_shots)
	if game.last_level_shot_bonus != 18:
		failures.append("shot bonus %d" % game.last_level_shot_bonus)
	if game.last_level_reward != 59:
		failures.append("total reward %d" % game.last_level_reward)
	if game.coin_count != 159:
		failures.append("final coin count %d" % game.coin_count)
	if game.level_complete_panel_rect.size.x <= 0.0:
		failures.append("complete panel not laid out")
	game._update_prompt()
	if game.prompt_label.text != "":
		failures.append("complete prompt should be empty")
	if game._displayed_level_complete_coin_total() != 100:
		failures.append("initial displayed total %d" % game._displayed_level_complete_coin_total())
	game._process(0.55)
	if game._displayed_level_complete_perfect_hits() <= 0:
		failures.append("perfect count did not start")
	if game._displayed_level_complete_remaining_shots() <= 0:
		failures.append("shot count did not start")
	game._process(2.0)
	if game._displayed_level_complete_coin_reward() != 59:
		failures.append("display reward final %d" % game._displayed_level_complete_coin_reward())
	if game._displayed_level_complete_coin_total() != 159:
		failures.append("display coin total final %d" % game._displayed_level_complete_coin_total())
	if game.level_complete_last_displayed_coin_reward <= 0:
		failures.append("coin chime/display tracker did not advance")
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("CLEAR_PANEL_REWARD_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
