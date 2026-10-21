extends SceneTree

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []
	game.settings_language = "en"
	game.current_level = 1
	game.coin_count = 1000
	game.menu_active = false
	game.aimer_charges = 0
	game.aimer_armed = false
	game._start_level()
	game._clear_level_intro()
	game._layout_powerup_slots()

	# First tap opens help, OK buys 3 charges and auto-equips.
	game.powerup_help_seen["aimer"] = false
	var aimer_rect: Rect2 = game.powerup_slots.get("aimer", Rect2())
	if aimer_rect.size.x <= 0.0:
		failures.append("aimer slot missing from powerup bar")
	game._handle_powerup_press(aimer_rect.get_center())
	if not game.powerup_help_active or game.powerup_help_id != "aimer":
		failures.append("first aimer press should open help")
	if game.aimer_armed or game.coin_count != 1000:
		failures.append("help should not charge or arm before OK")
	game._handle_powerup_help_press(game.powerup_help_ok_rect.get_center())
	if not game.aimer_armed:
		failures.append("aimer OK should arm")
	if game.aimer_charges != game.AIMER_CHARGE_COUNT:
		failures.append("purchase should grant %d charges, got %d" % [game.AIMER_CHARGE_COUNT, game.aimer_charges])
	if game.coin_count != 1000 - game.AIMER_COST:
		failures.append("aimer OK should charge cost once")

	# Tap with charges toggles equip without spending or refunding.
	game.last_powerup_press_time = -1000.0
	game._handle_powerup_press(aimer_rect.get_center())
	if game.aimer_armed:
		failures.append("tap while equipped should unequip")
	if game.aimer_charges != game.AIMER_CHARGE_COUNT or game.coin_count != 1000 - game.AIMER_COST:
		failures.append("toggle should keep charges and never move coins")
	game.last_powerup_press_time = -1000.0
	game._handle_powerup_press(aimer_rect.get_center())
	if not game.aimer_armed:
		failures.append("tap while unequipped should re-equip")

	# Each recorded shot while equipped consumes one charge.
	game._record_shot()
	if game.aimer_charges != game.AIMER_CHARGE_COUNT - 1 or not game.aimer_armed:
		failures.append("first shot should consume one charge and stay equipped")
	# Unequipped shots do not consume.
	game.aimer_armed = false
	game._record_shot()
	if game.aimer_charges != game.AIMER_CHARGE_COUNT - 1:
		failures.append("unequipped shot should not consume charges")
	game.aimer_armed = true
	game._record_shot()
	game._record_shot()
	if game.aimer_charges != 0 or game.aimer_armed:
		failures.append("last charge should auto-unequip at 0")

	# With 0 charges a tap buys again (help already seen).
	game.last_powerup_press_time = -1000.0
	game._handle_powerup_press(aimer_rect.get_center())
	if game.aimer_charges != game.AIMER_CHARGE_COUNT or game.coin_count != 1000 - game.AIMER_COST * 2:
		failures.append("repurchase should charge cost and refill charges")

	# Not enough coins refuses to buy.
	game.aimer_charges = 0
	game.aimer_armed = false
	game.coin_count = 10
	game.last_powerup_press_time = -1000.0
	game._handle_powerup_press(aimer_rect.get_center())
	if game.aimer_charges != 0 or game.coin_count != 10:
		failures.append("insufficient coins should refuse to buy")

	# Menu return keeps charges; armed follows charges.
	game.aimer_charges = 2
	game._show_start_menu()
	if game.aimer_charges != 2 or not game.aimer_armed:
		failures.append("menu return should keep charges and stay equipped")

	# clean shared save so later probes don't inherit aimer charges
	game.aimer_charges = 0
	game.aimer_armed = false
	game._save_progress(game.current_level)

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("AIMER_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
