extends CharacterBody2D


var bounce_strength: float = 0.5
var friction: float = 20
# used to help calculate bounce
var previous_y: float = 0


func _ready() -> void:
	var sprite: Sprite2D = $Sprite2D
	# add a little randomness to the shader
	sprite.set_instance_shader_parameter("meltness", randf_range(1.8, 2.2))
	sprite.set_instance_shader_parameter("how_deep", randf_range(0.8, 1.2))
	sprite.set_instance_shader_parameter("speed", randf_range(2.8, 3.2))
	sprite.set_instance_shader_parameter("wave_frequency", randf_range(9.5, 10.5))


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		previous_y = velocity.y
	elif previous_y > 100:
		velocity.y = -previous_y * bounce_strength
		previous_y = velocity.y
	
	velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
	
	move_and_slide()
