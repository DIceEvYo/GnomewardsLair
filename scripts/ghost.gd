extends CharacterBody2D

# used to prevent spam rotation
var ignore_input := false
static var is_player_alive := true

func _ready() -> void:
	is_player_alive = true
	velocity.x = 150

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		$Ghostttpx.flip_h = not $Ghostttpx.flip_h
		velocity.x *= -1

func _input(event: InputEvent) -> void:
	if ignore_input:
		return
	elif event.is_action("rotate_left"):
		_rotate_tween(rotation_degrees + 90)
		ignore_input = true
	elif event.is_action("rotate_right"):
		ignore_input = true
		_rotate_tween(rotation_degrees - 90)
	elif event is InputEventScreenTouch:
		if event.double_tap:
			if event.position.x > 480:
				_rotate_tween(rotation_degrees - 90)
				ignore_input = true
			else:
				_rotate_tween(rotation_degrees + 90)
				ignore_input = true

# physics objects must be a child of rotater to prevent phasing through objects
func _rotate_tween(rotate_to: float) -> void:
	var anim := create_tween()
	anim.tween_property(self, "rotation_degrees", rotate_to, 0.75)
	await anim.finished
	ignore_input = false
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerSlime and is_player_alive:
		is_player_alive = false
		$LoseSound.play()
		get_node("/root/Game/lose_screen").visible = true
		await $LoseSound.finished
		get_tree().call_deferred("reload_current_scene")
