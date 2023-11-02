extends Area2D


@export var damage : int = 20
@export var enemy : Wizard
@export var facing_shape : Facing_collision_polygon2D

@onready var last : bool = true
@onready var last2 : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring = false
	enemy.connect("facing_direction_changed", on_player_facing_direction_changed)

func on_player_facing_direction_changed(facing_right : bool):
	
	if(facing_right && last):
		facing_shape.position = facing_shape.facing_rigth_position
		var area = get_children()
		area[0].rotate(90)
		last2 = true
		last = false
		
	elif(last2 && !facing_right):
		var area = get_children()
		facing_shape.position = facing_shape.facing_left_position
		area[0].rotate(-90)
		last = true
		last2 = false

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			if(direction_sign > 0):
				child.hit(damage, Vector2.RIGHT)
			elif (direction_sign < 0):
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)
