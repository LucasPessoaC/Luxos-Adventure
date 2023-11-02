extends State

class_name HitState

@export var damageable : Damageable
@export var dead_state : State 
@export var idle_state : State 
@onready var hit_state : State =  $Hit

@export var character_state_machine : CharacterStateMachine
@export var dead_animation_node : String
@export var knockback_velocity : float = 600.0
@export var return_state : State
@onready var timer : Timer = $Timer
@onready var hitBox = $"../../HitBox"
@onready var col = $"../../CollisionShape2D"
@onready var drops = [preload("res://Collectables/Potion01.tscn").instantiate(),
					 preload("res://Collectables/Potion02.tscn").instantiate(),
					 preload("res://Collectables/copper_coin.tscn").instantiate(),
					 preload("res://Collectables/silver_coin.tscn").instantiate(),
					preload("res://Collectables/bone.tscn").instantiate(),]


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
		if character_state_machine.current_state != dead_state : 
			hitBox.queue_free()
			col.queue_free()
		emit_signal("interrupt_state", dead_state)
		await dropItem()
		playback.travel(dead_animation_node)
		

func dropItem():
	var rng = RandomNumberGenerator.new()
	var randomAngle = rng.randf_range(0.0, 360.0)
	for item in drops:
		var chance = rng.randi_range(1,101)
		var quant = rng.randi_range(1,4)
		var quant2 = rng.randi_range(1,3)
		
		if(chance <= 20):
			if(quant2 == 1):
				get_tree().root.call_deferred("add_child", drops[1])
				drops[1].global_position.x = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.x
				drops[1].global_position.y = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.y
			else:
				get_tree().root.call_deferred("add_child", drops[3])
				drops[3].global_position.x = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.x
				drops[3].global_position.y = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.y
		elif(chance >= 20):
			if(quant2 == 1):
				get_tree().root.call_deferred("add_child", drops[0])
				drops[0].global_position.x = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.x
				drops[0].global_position.y = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.y
			if(quant2 == 2):
				get_tree().root.call_deferred("add_child", drops[2])
				drops[2].global_position.x = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.x
				drops[2].global_position.y = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.y
			if(quant2 == 3):
				get_tree().root.call_deferred("add_child", drops[4])
				drops[4].global_position.x = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.x
				drops[4].global_position.y = rng.randf_range(-40.0, 40.0) + get_parent().get_parent().global_position.y
			


func _on_timer_timeout():
	if(character_state_machine.current_state != dead_state ):
		next_state = return_state
