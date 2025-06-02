extends Node2D

var timer: Timer
var elapsed_time: float

func _ready() -> void:
	tween_slimeboi()

		
func tween_slimeboi():
	var slimy_tween: Tween = create_tween()
	slimy_tween.tween_property($SLIME, "position", Vector2(330,0), 1.5)
	slimy_tween.tween_property($GNOMIEHOMIE, "position", Vector2(550,317), 1.5)
