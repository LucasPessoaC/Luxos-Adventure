extends CharacterBody2D

class_name Wizard


@export var speed : float = 50.0

@onready var animation_tree : AnimationTree = $AnimationTree

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var states_machine = animation_tree.get("parameters/playback")
@export var hit_state : State
@export var dead_state : State
@export var attack_state : State

@onready var attackBox = $Area2D/AttackArea
@onready var los = $LineOfSight
@export var nav_agent: NavigationAgent2D
@export var player: Node2D

@onready var sprite : Sprite2D = $Sprite2D

var player_spotted: bool = false

signal facing_direction_changed(facing_right : bool)
signal isInAttackArea(isPresent : bool)


func _ready():
	animation_tree.active = true
	nav_agent.target_desired_distance = 50.0
	nav_agent.path_desired_distance = 50.0
	path()
	
	
func checkPlayer() -> bool:
	var collider = los.get_collider()
	if(collider and collider.is_in_group("player")):
		player_spotted = true
		return true
	else:
		player_spotted = false
	return false
	
func path():
	if(state_machine.current_state != hit_state):
		nav_agent.target_position = player.global_position
	else:
		nav_agent.target_position = position

func _physics_process(delta):
	var dist = global_position - player.global_position
	if(dist.x <= 120.0 && dist.x >= -120.0 && dist.y <= 120 && dist.y >= -120 && state_machine.current_state != attack_state && state_machine.current_state != hit_state && state_machine.current_state != dead_state):
		emit_signal("facing_direction_changed", !sprite.flip_h)
		emit_signal("isInAttackArea", true)
		state_machine.switch_states(attack_state)
	else:
		if(state_machine.current_state == attack_state ):
			emit_signal("isInAttackArea", false)
	
	los.look_at(player.global_position)
	checkPlayer()
	if(player_spotted && state_machine.current_state != hit_state && state_machine.current_state != attack_state && state_machine.current_state != dead_state):
		states_machine.travel("run")
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		
		if dir && state_machine.check_if_can_move():
			velocity.x = dir.x * speed
			velocity.y = dir.y * speed
			if(velocity.x > 0):
				sprite.flip_h = false
			else:
				sprite.flip_h = true
					
	else:
		if(state_machine.current_state != hit_state && state_machine.current_state != attack_state && state_machine.current_state != dead_state):
			velocity = Vector2.ZERO
			states_machine.travel("idle")
	move_and_slide()
	
func _on_timer_timeout():
	path()
