extends CharacterBody2D

class_name Skeleton

enum SKELETON_STATE{IDLE, WALK}

@export var speed : float = 50.0
@onready var animation_tree : AnimationTree = $AnimationTree
@export var hit_state : State
@export var dead_state : State
@export var attack_state : State

@onready var los = $LineOfsight
@export var nav_agent: NavigationAgent2D
@export var player: Node2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var collisionHitBox : CollisionShape2D = $HitBox/HitBoxShape

@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var states_machine = animation_tree.get("parameters/playback")
@onready var timer = $TimerSkeleton
@onready var walk = $walk

signal facing_direction_changed(facing_right : bool)
signal isInAttackArea(isPresent : bool)

var player_spotted: bool = false
var control : bool

var current_state : SKELETON_STATE = SKELETON_STATE.IDLE

func _ready():
	animation_tree.active = true
	nav_agent.target_desired_distance = 50.0
	nav_agent.path_desired_distance = 50.0
	path()

func _physics_process(_delta: float) -> void:
#Attack Animation distance
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
			velocity = dir * speed
			if(!walk.playing):
				walk.play()
				
			if(velocity.x > 0):
				sprite.flip_h = false
				collision.position.x = -11.333
				collisionHitBox.position.x = -10
			else:
				sprite.flip_h = true
				collision.position.x = 5.3333
				collisionHitBox.position.x = 5.3333
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


