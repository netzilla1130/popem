extends SceneTree

func _init() -> void:
	var scene: PackedScene = load("res://scenes/main.tscn")
	var game = scene.instantiate()
	root.add_child(game)
	for i in range(10):
		await process_frame
	var ready: bool = game.menu_active and game.start_menu_buttons.size() > 0
	await load("res://tests/test_cleanup.gd").finish(game, self)
	if ready:
		print("STARTUP_SMOKE_OK")
		quit(0)
	else:
		printerr("Start menu failed to initialize")
		quit(1)
