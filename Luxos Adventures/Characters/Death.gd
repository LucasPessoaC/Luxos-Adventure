extends State

@export var death_animation : String = "Death"
@export var attack_animation : String = "Attack_1"

func dead():
	playback.travel("Death")
	
	
