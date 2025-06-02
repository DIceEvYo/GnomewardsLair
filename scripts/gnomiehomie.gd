extends CharacterBody2D

var position_reached: bool = false
var stage: int = 0

func _ready() -> void:
	%Pixelbubble/bubbly.text = "You really 
thought you 
could escape?"

func _process(delta: float) -> void:
	if(position.x < 560):
		%Pixelbubble.show()
		%Pixelbubble/bubbly.show()
		%YOUWINCOOL.hide()
		_position_reached()
		
func _position_reached():
	if (not position_reached):
		$Timer.start(1.5)
		position_reached = true

func _on_timer_timeout() -> void:
	if stage == 0:
		%Pixelbubble/bubbly.text = "Keep dreamin bud. Imma slice u up boi"
		$Timer.start(1.5)
	elif stage == 1:
		%Pixelbubble.hide()
		%Pixelbubble/bubbly.hide()
		$Slicey.play()
		%Makkuro.show()
		%Gnomewardpxholyshttt.show()
		await $Slicey.finished
	stage += 1
		
	
