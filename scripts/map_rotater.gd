extends Node2D
## Note map rotater should be positioned in the middle of the screen and
## child map should be offset to center (handled in _ready)


var current_level: TileMapLayer
var levels: Array[PackedScene] = [
	preload("res://scenes/level_1.tscn"),
]
# used to prevent spam rotation
var ignore_input := false


func _ready() -> void:
	current_level = levels[0].instantiate()
	add_child(current_level)
	# 32x32 tilemap with 16x16 tiles = 512x512.
	# all maps should be 32x32 to remain centered/on screen.
	current_level.position = Vector2(-256, -256)


func _input(event: InputEvent) -> void:
	if ignore_input:
		return
	elif event.is_action("rotate_left"):
		_rotate_tween(rotation_degrees - 90)
		ignore_input = true
	elif event.is_action("rotate_right"):
		ignore_input = true
		_rotate_tween(rotation_degrees + 90)


# physics objects must be a child of rotater to prevent phasing through objects
func _rotate_tween(rotate_to: float) -> void:
	var anim := create_tween()
	anim.tween_property(self, "rotation_degrees", rotate_to, 0.75)
	await anim.finished
	ignore_input = false
