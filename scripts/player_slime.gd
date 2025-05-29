extends CharacterBody2D


var bounce_strength: float = 0.5
var friction: float = 20
# used to help calculate bounce
var previous_y: float = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		previous_y = velocity.y
	elif previous_y > 100:
		velocity.y = -previous_y * bounce_strength
		print(velocity.y)
		previous_y = velocity.y
	
	velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
	
	move_and_slide()
