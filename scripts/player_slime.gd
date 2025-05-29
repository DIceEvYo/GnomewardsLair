extends CharacterBody2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.move_toward(Vector2.ZERO, delta)
	
	move_and_slide()
