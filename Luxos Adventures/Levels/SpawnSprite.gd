extends Sprite2D

@export var rotation_speed: int

@onready var enemy = preload("res://Characters/Enemies/Skeleton.tscn")
@onready var animation = $AnimationPlayer

var start: bool = false


func _process(delta):
	rotation += delta * rotation_speed
	
	if(!animation.is_playing() && !start):
		animation.play("expand")
		start = true



func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "expand"):
		var Enemy = enemy.instantiate()
		Enemy.player = get_tree().get_first_node_in_group("player")
		Enemy.position = self.position
		get_parent().add_child(Enemy)
		
		animation.play("retract")
	else:
		self.queue_free()
