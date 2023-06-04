extends State

class_name IdleState

@export var attack_state : State
@export var run_state : State

@export var attack_animation : String = "Attack_1"
@export var run_animation : String = "run"


func state_input(event : InputEvent):
	if(event.is_action_pressed("attack")):
		attack()
		
	#if(event.is_action_pressed("down") || event.is_action_pressed("up") || event.is_action_pressed("right") || event.is_action_pressed("left")):
	#	run()
		
		
func attack():
	next_state = attack_state
	playback.travel(attack_animation)
	velocity = Vector2.ZERO
	
func run():
	next_state = run_state
	playback.travel(run_animation)
