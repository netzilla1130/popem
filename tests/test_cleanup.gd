extends RefCounted

static func finish(game: Node, tree: SceneTree) -> void:
	# Let the audio server release active streams before the test process exits.
	game.set_process(false)
	for child in game.get_children():
		if child is AudioStreamPlayer:
			child.stop()
			child.stream = null
	game.queue_free()
	await tree.process_frame
	await tree.create_timer(0.1).timeout
