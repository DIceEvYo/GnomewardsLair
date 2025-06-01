extends CharacterBody2D
class_name PlayerSlime

var bounce_strength: float = 0.5
var friction: float = 20
# used to help calculate bounce
var previous_y: float = 0

var shape_size: float
@onready var collision_shape_player := $CollisionShape2D
@onready var collision_shape_area2d := $Area2D/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	shape_size = collision_shape_player.shape.size.x
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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self:
		return
	elif body is PlayerSlime:
		# arbitary way to ensure that if two players collide only one of them gets freed, not both
		if name > body.name:
			# increase size to match combined area
			shape_size = sqrt((shape_size ** 2.0) + (body.shape_size ** 2.0))
			sprite.scale = Vector2((shape_size + 1) * 0.01, (shape_size + 1) * 0.01)
			collision_shape_player.shape.size = Vector2(shape_size, shape_size)
			collision_shape_area2d.shape.size = Vector2(shape_size + 1, shape_size + 1)
			body.queue_free()
