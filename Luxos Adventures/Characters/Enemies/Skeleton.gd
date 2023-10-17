extends CharacterBody2D

class_name Skeleton

enum SKELETON_STATE{IDLE, WALK}

@export var speed : float = 50.0
@export var starting_direction_move : Vector2 = Vector2.LEFT
@onready var animation_tree : AnimationTree = $AnimationTree
@export var hit_state : State
@export var dead_state : State
@export var attack_state : State

@export var idle_time : float = 2
@export var walk_time : float = 3

@onready var los = $LineOfsight

@export var player: Node2D
@export var nav_agent: NavigationAgent2D


@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var states_machine = animation_tree.get("parameters/playback")
@onready var timer = $TimerSkeleton

signal facing_direction_changed(facing_right : bool)
signal isInAttackArea(isPresent : bool)

var player_spotted: bool = false
var control : bool


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var move_direction : Vector2 = Vector2.ZERO
var current_state : SKELETON_STATE = SKELETON_STATE.IDLE

func _ready():
	animation_tree.active = true
	nav_agent.target_desired_distance = 50.0
	nav_agent.path_desired_distance = 50.0
	path()
	
func select_new_direction():
	move_direction = Vector2(randi_range(-1,1), randi_range(-1,1))


func _physics_process(_delta: float):
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
	var dist = global_position - player.global_position
	if(dist.x <= 40.0 && dist.x >= -40.0 && dist.y <= 40 && dist.y >= -40 && state_machine.current_state != attack_state && state_machine.current_state != hit_state && state_machine.current_state != dead_state):
		emit_signal("facing_direction_changed", !sprite.flip_h)
		emit_signal("isInAttackArea", true)
		state_machine.switch_states(attack_state)
	else:
		if(state_machine.current_state == attack_state ):
			emit_signal("isInAttackArea", false)
		
	
	los.look_at(player.global_position)
	checkPlayer()
	if(player_spotted && state_machine.current_state != hit_state && state_machine.current_state != attack_state && state_machine.current_state != dead_state):
		states_machine.travel("walk")
		current_state = SKELETON_STATE.WALK
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		
		if dir && state_machine.check_if_can_move() && current_state == SKELETON_STATE.WALK:
			velocity.x = dir.x * speed
			velocity.y = dir.y * speed
			if(velocity.x > 0):
				sprite.flip_h = false
			else:
				sprite.flip_h = true
				
		
	else:
		if(state_machine.current_state != hit_state && state_machine.current_state != attack_state && state_machine.current_state != dead_state):
			velocity = Vector2.ZERO
			states_machine.travel("Idle")
			current_state = SKELETON_STATE.IDLE
		
	move_and_slide()
	
func checkPlayer() -> bool:
	var collider = los.get_collider()
	if(collider and collider.is_in_group("player")):
		player_spotted = true
		return true
	else:
		player_spotted = false
	return false

func actor_setup():
	await get_tree().physics_frame
	path()

func path():
	if(state_machine.current_state != hit_state):
		nav_agent.target_position = player.global_position
	else:
		nav_agent.target_position = position

func _on_timer_timeout():
	path()


