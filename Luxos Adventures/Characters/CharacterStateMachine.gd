extends Node


class_name CharacterStateMachine

var states : Array[State]

@export var character : CharacterBody2D
@export var current_state : State
@export var animation_tree : AnimationTree 

@onready var deathState = $Death

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			child.character = character
			child.velocity = character.get("velocity")
			child.playback = animation_tree["parameters/playback"]
			#connect to interrupt signal
			child.connect("interrupt_state", on_state_interrupt_state)
			
		else:
			push_warning("Child " + child.name + "is not a State for CharacterStateMachine")
			
			
func _physics_process(_delta):
	if(current_state.next_state != null):
		
		switch_states(current_state.next_state)
		
	current_state.state_process(_delta)


func check_if_can_move():
	return current_state.can_move 


func switch_states(new_state : State):
	if (current_state != null):
		current_state.on_exit()
		current_state.next_state = null
		

	current_state = new_state
	current_state.on_enter()
	
	
func _input(event : InputEvent):
	current_state.state_input(event)
	
func on_state_interrupt_state(new_state : State):
	switch_states(new_state)


func _on_player_main_zero_health():
	on_state_interrupt_state(deathState)
	$Death.dead()

