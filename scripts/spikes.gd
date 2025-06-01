extends Area2D

static var is_player_alive := true


func _ready() -> void:
	is_player_alive = true


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerSlime and is_player_alive:
		is_player_alive = false
		$LoseSound.play()
		get_node("/root/Game/lose_screen").visible = true
		await $LoseSound.finished
		get_tree().call_deferred("reload_current_scene")
