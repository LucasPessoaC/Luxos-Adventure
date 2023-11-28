extends State

@export var return_state : State
@export var return_animation_node : String = "idle"
@export var attack1_name : String = "Attack_1"
@export var attack2_name : String = "Attack_2"
@export var attack3_name : String = "Attack_3"


@export var attack2_node : String = "Attack_2"
@export var attack3_node : String = "Attack_3"
@onready var attack_1 = $"../../attack1"


@onready var timer : Timer = $Timer


func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		if(timer.is_stopped()):
			timer.start()
		


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == attack1_name):
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(return_animation_node)
		else:
			playback.travel(attack2_node)
			attack_1.pitch_scale = 1.55
			attack_1.play()
		
	if (anim_name == attack2_name):
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(return_animation_node)
			
		else:
			playback.travel(attack3_node)
			attack_1.pitch_scale = 0.5
			attack_1.play()
			
	if (anim_name == attack3_name):
			timer.stop()
			next_state = return_state
			playback.travel(return_animation_node)
		
