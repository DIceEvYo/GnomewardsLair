extends Button

func _ready() -> void:
	%Words.text = "If there was a trolly racing at a group of 5 robotic cats with sentience or 3 babies and 1 dog, where one of the babies will grow up to become an evil dictator and take over the world, who would you choose to save?"

func _on_pressed() -> void:
	%Words.text = "WRONG CHOICE"
	%Timer.start(1)


func _on_button_2_pressed() -> void:
	%Words.text = "WRONG CHOICE"
	%Timer.start(1)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
