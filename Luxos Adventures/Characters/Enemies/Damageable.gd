extends Node
class_name Damageable

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var health : int = 100:
	get: 
		return health 
	set(value):
		health = value
		
		
@export var dead_animation_name : String = "Death"

func hit(damage : int, knockback_direction : Vector2):
	
	health -= damage
	var parent = get_parent()
	if(parent.name == "Wizard"):
		SignalBus.emit_signal("updateBossBar", damage)
	SignalBus.emit_signal("on_health_changed", get_parent(), -damage)
	emit_signal("on_hit", get_parent(), damage, knockback_direction)

func hitCollided(damage: int):
	health -= damage
	
func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):

		get_parent().queue_free()
