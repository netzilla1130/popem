extends RefCounted

static func finish(game: Node, tree: SceneTree) -> void:
	# Let the audio server release active streams before the test process exits.
	game.set_process(false)
	# A probe can queue play/stop calls in one frame. Let pending playback
	# reach the audio server before stopping it, including on Linux Dummy.
	await tree.process_frame
	await tree.create_timer(0.1).timeout
	for child in game.get_children():
		if child is AudioStreamPlayer:
			child.stop()
			child.stream = null
	await tree.create_timer(0.2).timeout
	game.queue_free()
	await tree.process_frame
	await tree.create_timer(0.1).timeout
