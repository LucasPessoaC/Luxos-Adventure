extends State

class_name IdleState

@export var attack_state : State
@export var run_state : State


@export var attack_animation : String = "Attack_1"
@export var run_animation : String = "run"

@export var death_animation : String = "Death"
func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
#		pass
		attack()
		
		

func attack():
	character = $Player_Main
	next_state = attack_state
	playback.travel(attack_animation)
	velocity.x = -0
	
func run():
	next_state = run_state
	playback.travel(run_animation)
