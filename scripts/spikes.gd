extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerSlime:
		$LoseSound.play()
		get_node("/root/Game/lose_screen").visible = true
		await $LoseSound.finished
		get_tree().call_deferred("reload_current_scene")
