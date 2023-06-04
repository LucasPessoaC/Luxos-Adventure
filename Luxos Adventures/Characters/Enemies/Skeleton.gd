extends CharacterBody2D

enum SKELETON_STATE{IDLE, WALK}

@export var speed : float = 50.0
@export var starting_direction_move : Vector2 = Vector2.LEFT
@onready var animation_tree : AnimationTree = $AnimationTree
@export var hit_state : State
@export var dead_state : State

@export var idle_time : float = 2
@export var walk_time : float = 3


@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var states_machine = animation_tree.get("parameters/playback")
@onready var timer = $TimerSkeleton


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var move_direction : Vector2 = Vector2.ZERO
var current_state : SKELETON_STATE = SKELETON_STATE.IDLE

func _ready():
	animation_tree.active = true
	select_new_direction()
	pick_new_state() 
	
func select_new_direction():
	move_direction = Vector2(randi_range(-1,1), randi_range(-1,1))


func _physics_process(delta):


#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : Vector2 = move_direction
	if direction && state_machine.check_if_can_move() && current_state == SKELETON_STATE.WALK:
		velocity.x = direction.x * speed
		if(velocity.x > 0):
			sprite.flip_h = false
		else:
			sprite.flip_h = true
			
	elif state_machine.current_state != hit_state && current_state == SKELETON_STATE.WALK:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
func pick_new_state():
	if(current_state == SKELETON_STATE.IDLE && state_machine.current_state != dead_state):
		states_machine.travel("walk")
		current_state = SKELETON_STATE.WALK
		select_new_direction()
		timer.start(walk_time)
	elif (current_state == SKELETON_STATE.WALK && state_machine.current_state != dead_state):
		states_machine.travel("Idle")
		current_state = SKELETON_STATE.IDLE
		timer.start(idle_time)
		move_direction = Vector2(0,0)
		


func _on_timer_timeout():
	pick_new_state()
