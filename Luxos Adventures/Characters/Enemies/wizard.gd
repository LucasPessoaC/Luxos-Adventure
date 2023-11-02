extends CharacterBody2D


@export var speed : float = 50.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var los = $LineOfSight
@export var nav_agent: NavigationAgent2D
@export var player: Node2D

@onready var sprite : Sprite2D = $Sprite2D

var player_spotted: bool = false


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
	los.look_at(player.global_position)
	checkPlayer()
	move_and_slide()
