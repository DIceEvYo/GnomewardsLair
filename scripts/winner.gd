extends Node2D


func _ready() -> void:
	tween_slimeboi()

		
func tween_slimeboi():
	var slimy_tween: Tween = create_tween()
	slimy_tween.tween_property($SLIME, "position", Vector2(330,0), 1.5)
	slimy_tween.tween_property($GNOMIEHOMIE, "position", Vector2(550,317), 1.5)
	await slimy_tween.finished
	if Global.current_level >= 1:
		return
	else:
		Global.current_level += 1
		get_tree().change_scene_to_file("res://scenes/game.tscn")
