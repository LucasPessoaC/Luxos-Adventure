extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state : State 
@export var idle_state : State 
@onready var hit_state : State =  $Hit

@export var character_state_machine : CharacterStateMachine
@export var dead_animation_node : String = "Death"
@export var knockback_velocity : float = 600.0
@export var return_state : State
@onready var timer : Timer = $Timer
@onready var hitBox = $"../../HitBox"

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	
func on_enter():
	timer.start()
	
func on_exit():
	character.velocity = Vector2.ZERO


func on_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	if(damageable.health > 0):
		emit_signal("interrupt_state", self)
		node.velocity = Vector2.ZERO
		character.velocity = Vector2.ZERO
		velocity = Vector2.ZERO
		character.velocity = knockback_velocity * knockback_direction
		
	else:
		character.velocity = Vector2.ZERO
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation_node)
		hitBox.queue_free()
		

func _on_timer_timeout():
	next_state = return_state
