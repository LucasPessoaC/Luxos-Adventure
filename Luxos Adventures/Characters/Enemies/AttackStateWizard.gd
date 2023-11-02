extends State

class_name AttackStateWizard

@export var attack_animation_node : String = "attack1"
@export var idle_animation_node : String = "idle"
@export var idle_state: State
@export var attack_state: State
@export var enemy : Wizard
@onready var timer : Timer = $AttackTimer
@onready var a = get_parent()

@onready var present : bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy.connect("isInAttackArea", isInArea)

func on_enter():
	playback.travel(attack_animation_node)
#	timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(_delta):
#	&& playback.get_current_node() == "walk"
	if(a.current_state == attack_state  ):
		playback.travel(attack_animation_node)
		velocity = Vector2.ZERO
		character.velocity = Vector2.ZERO
#		a.switch_states(idle_state)
		

func isInArea(value : bool):
	if(value):
		present = true

	else:
		present = false
		

func _on_animation_tree_animation_finished(_anim_name):
	if(present):
		
#		playback.start("attack1", true)
		pass
	else:
		if(a.current_state == attack_state):
			playback.travel(idle_animation_node)
			a.switch_states(idle_state)
