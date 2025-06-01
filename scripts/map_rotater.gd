extends Node2D
## Note map rotater should be positioned in the middle of the screen and
## child map should be offset to center (handled in _ready)


var current_level: TileMapLayer
var levels: Array[PackedScene] = [
	preload("res://scenes/level_1.tscn"),
]
# used to prevent spam rotation
var ignore_input := false

var player_slime_scene: PackedScene = preload("res://scenes/player_slime.tscn")

func _ready() -> void:
	current_level = levels[0].instantiate()
	add_child(current_level)
	# 43x43 tilemap with 16x16 tiles = 688x688.
	# all maps should be 43x43 to remain centered/on screen.
	current_level.position = Vector2(-344, -344)
	
	var spawn_tile_coords: Array[Vector2i] = current_level.get_used_cells_by_id(1)
	for i in spawn_tile_coords.size():
		var player_slime: CharacterBody2D = player_slime_scene.instantiate()
		add_child(player_slime)
		# this is quite the wombo combo, not pretty but it gets the job done
		player_slime.global_position = current_level.to_global(current_level.map_to_local(spawn_tile_coords[i]))
		player_slime.progress_cap = spawn_tile_coords.size()


func _input(event: InputEvent) -> void:
	if ignore_input:
		return
	elif event.is_action("rotate_left"):
		_rotate_tween(rotation_degrees - 90)
		ignore_input = true
	elif event.is_action("rotate_right"):
		ignore_input = true
		_rotate_tween(rotation_degrees + 90)
	elif event is InputEventScreenTouch:
		if event.double_tap:
			if event.position.x > 480:
				_rotate_tween(rotation_degrees + 90)
				ignore_input = true
			else:
				_rotate_tween(rotation_degrees - 90)
				ignore_input = true

# physics objects must be a child of rotater to prevent phasing through objects
func _rotate_tween(rotate_to: float) -> void:
	var anim := create_tween()
	anim.tween_property(self, "rotation_degrees", rotate_to, 0.75)
	await anim.finished
	ignore_input = false
