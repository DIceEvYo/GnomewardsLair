extends CharacterBody2D
var slime_speed: float = 75

func moveyourbooty():
	velocity.x = slime_speed
	move_and_slide()

func yametekureyo():
	velocity.x = 0
