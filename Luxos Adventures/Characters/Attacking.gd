extends State

@export var return_state : State
@export var return_animation_node : String = "idle"
@export var attack1_name : String = "Attack_1"
@export var attack2_name : String = "Attack_2"
@export var attack3_name : String = "Attack_3"


@export var attack2_node : String = "Attack_2"
@export var attack3_node : String = "Attack_3"


@onready var timer : Timer = $Timer

func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		timer.start()
		


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == attack1_name):
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(return_animation_node)
		else:
			playback.travel(attack2_node)
		
	if (anim_name == attack2_name):
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(return_animation_node)
		else:
			playback.travel(attack3_node)
			
	if (anim_name == attack3_name):
			next_state = return_state
			playback.travel(return_animation_node)
		
