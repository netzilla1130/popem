extends SceneTree

# 2026-07-12 fixes: ①bomb cards/confirm show FULL names in every language;
# ②first-tap powerup intro dialog has a CANCEL button — OK proceeds to the
# activation flow, cancel (or tapping outside) closes without buying.

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	await process_frame
	var failures: Array[String] = []

	# --- Bomb full names per language ---
	game.settings_language = "en"
	if game._bomb_slot_title("red") != "RED BOMB":
		failures.append("en bomb title: got %s" % game._bomb_slot_title("red"))
	game.settings_language = "zh"
	if game._bomb_slot_title("red") != "红色炸弹":
		failures.append("zh bomb title: got %s" % game._bomb_slot_title("red"))
	game.settings_language = "zh_hant"
	if game._bomb_slot_title("blue") != "藍色炸彈":
		failures.append("zh_hant bomb title: got %s" % game._bomb_slot_title("blue"))
	if game._powerup_confirm_title("bomb_yellow") != "黃色炸彈":
		failures.append("zh_hant confirm title: got %s" % game._powerup_confirm_title("bomb_yellow"))
	game.settings_language = "en"

	# --- Help dialog: cancel must not buy ---
	game.current_level = 8
	game.menu_active = false
	game._start_level()
	game._clear_level_intro()
	game.coin_count = 1000
	game.powerup_help_seen.clear()

	game._show_powerup_help("crystal", "crystal")
	if not game.powerup_help_active:
		failures.append("help dialog should open")
	if game.powerup_help_cancel_rect.size.x <= 0.0:
		failures.append("cancel button should have a rect")
	if game.powerup_help_ok_rect.intersects(game.powerup_help_cancel_rect):
		failures.append("ok and cancel buttons overlap")
	var coins_before: int = game.coin_count
	game._handle_powerup_help_press(game.powerup_help_cancel_rect.get_center())
	if game.powerup_help_active:
		failures.append("cancel should close the dialog")
	if game.coin_count != coins_before:
		failures.append("cancel must not spend coins (%d -> %d)" % [coins_before, game.coin_count])
	if game.armed_special_kind != "":
		failures.append("cancel must not arm a special")
	if not bool(game.powerup_help_seen.get("crystal", false)):
		failures.append("cancel should still mark the intro as seen")

	# --- Help dialog: OK still proceeds to activation (buys the crystal) ---
	game.powerup_help_seen.clear()
	game._show_powerup_help("crystal", "crystal")
	coins_before = game.coin_count
	game._handle_powerup_help_press(game.powerup_help_ok_rect.get_center())
	if game.powerup_help_active:
		failures.append("ok should close the dialog")
	if game.coin_count >= coins_before:
		failures.append("ok should proceed to the purchase (coins %d -> %d)" % [coins_before, game.coin_count])
	if game.armed_special_kind != "crystal":
		failures.append("ok should arm the crystal, got '%s'" % game.armed_special_kind)

	# --- Tap outside the buttons: same as cancel ---
	game._cancel_armed_special()
	game.powerup_help_seen.clear()
	game._show_powerup_help("crystal", "crystal")
	coins_before = game.coin_count
	game._handle_powerup_help_press(game.powerup_help_dialog_rect.position - Vector2(4.0, 4.0))
	if game.powerup_help_active:
		failures.append("outside tap should close the dialog")
	if game.coin_count != coins_before:
		failures.append("outside tap must not spend coins")
	if not bool(game.powerup_help_seen.get("crystal", false)):
		failures.append("outside tap should mark the intro as seen")

	await load("res://tests/test_cleanup.gd").finish(game, self)
	if failures.is_empty():
		print("POWERUP_HELP_CANCEL_PROBE_OK")
		quit(0)
	else:
		for failure in failures:
			printerr(failure)
		quit(1)
