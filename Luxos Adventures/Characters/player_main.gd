extends CharacterBody2D

class_name Player


@export var move_speed : float = 100
@export var knockback_velocity : float = 1500.0
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree

@onready var sprite : Sprite2D = $Sprite2D
@onready var damage : Damageable = $Damageable
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var character_state_machine : CharacterStateMachine = $CharacterStateMachine

@export var maxHealth = 100
@onready var current_health : int = maxHealth/25
@onready var death_State = character_state_machine.find_child("Death", true, false)
@onready var isHitted : bool
var count : int = 0 

signal facing_direction_changed(facing_right : bool)
signal healthChanged
signal zeroHealth

func _ready():
	update_animation_parameters(starting_direction)
	damage.connect("on_hit", on_hit)
	
func get_input():
		velocity = Vector2.ZERO
		
		if Input.is_action_pressed('right'):
			velocity.x += 1
			sprite.set("flip_h", false)
		if Input.is_action_pressed('left'):
			velocity.x -= 1
			sprite.set("flip_h", true)
		if Input.is_action_pressed('down'):
			velocity.y += 1
		if Input.is_action_pressed('up'):
			velocity.y -= 1
		emit_signal("facing_direction_changed", !sprite.flip_h)
			
		update_animation_parameters(velocity)
		# Make sure diagonal movement isn't faster
		velocity = velocity.normalized() * move_speed

@warning_ignore("unused_parameter")
func _physics_process(delta):
	#Atualizar a velocidade e pegar as direções de entrada
	if(character_state_machine.current_state != death_State && !isHitted):
		get_input()
	if(character_state_machine.check_if_can_move()):
		print(velocity)
		move_and_slide()
	handleColision()
	#pick_new_state()
	isHitted = false
	

func handleColision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
#		print_debug(collider.name)

func update_animation_parameters(move_input: Vector2):
	animation_tree.set("parameters/idle/blend_position", move_input)

func on_hit(node : Node, damage_taken : int, knockback_direction : Vector2):
	isHitted = true
	velocity = Vector2.ZERO
	velocity = knockback_velocity * knockback_direction

func _on_hurt_box_area_entered(area):
	if area.name == "HitBox":
		healthChanged.emit(current_health-1,0)
		count += 1
		if(count >= 4):
			current_health -= 1
			count = 0
		if(current_health == 0):
			emit_signal("zeroHealth")
