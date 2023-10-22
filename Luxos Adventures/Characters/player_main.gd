extends CharacterBody2D

class_name Player


@export var move_speed : float = 100
@export var knockback_velocity : float = 1500.0
@export var starting_direction : Vector2 = Vector2(0, 1)
@export var inventory: Inventory

@onready var animation_tree = $AnimationTree


@onready var sprite : Sprite2D = $Sprite2D
@onready var damage : Damageable = $Damageable
@onready var hitEffect = $HurtEffect
@onready var hurtTimer = $BlinkTimer
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var character_state_machine : CharacterStateMachine = $CharacterStateMachine

@export var maxHealth = 100
@warning_ignore("integer_division")
@onready var current_health : int = maxHealth/20
@onready var health : int = maxHealth

@onready var death_State = character_state_machine.find_child("Death", true, false)
@onready var isHitted : bool
@onready var hurtBox = $HurtBox
var hitted : bool = false

var count : int = 0 

signal facing_direction_changed(facing_right : bool)

signal wasAttacked
signal zeroHealth
signal potionChanged

func _ready():
	update_animation_parameters(starting_direction)
	damage.connect("on_hit", on_hit)
	hitEffect.play("RESET")
	
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
		if Input.is_action_pressed("Heal"):
			if(inventory.potionSlot[0].item != null):
				
				if(inventory.potionSlot[0].item.name == "Small Potion"):
					wasAttacked.emit(health,-20)
				if(inventory.potionSlot[0].item.name == "Medium Potion"):
					wasAttacked.emit(health,-50)
				if(inventory.potionSlot[0].item.name == "Great Potion"):
					wasAttacked.emit(health,-100)
			else:
				pass
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
		move_and_slide()
	handleColision()
	isHitted = false
	if !hitted:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "HitBox":
				hurtByEnemy(area)
	


func handleColision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

func update_animation_parameters(move_input: Vector2):
	animation_tree.set("parameters/idle/blend_position", move_input)

func on_hit(node : Node, damage_taken : int, knockback_direction : Vector2):
	if isHitted : return
	isHitted = true
	velocity = Vector2.ZERO
	velocity = knockback_velocity * knockback_direction
	wasAttacked.emit(health,damage_taken)
	health = health - damage_taken
	hitEffect.play("Blink")
	hurtTimer.start()
	await hurtTimer.timeout
	hitEffect.play("RESET")
	isHitted = false
	if(health <= 0 && character_state_machine.current_state != death_State):
		emit_signal("zeroHealth")
		health = health - 10
	
	
func hurtByEnemy(area):
	wasAttacked.emit(health,10)
	hitted = true
	health = health - 10
	if(health <= 0 && character_state_machine.current_state != death_State):
		emit_signal("zeroHealth")
	hitEffect.play("Blink")
	hurtTimer.start()
	await hurtTimer.timeout
	hitEffect.play("RESET")
	hitted = false


func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect(inventory)


func _on_hurt_box_area_exited(area): pass


func _on_inventory_gui_potion_changed():
#	if(inventory.potionSlot[0].item != null):
	var a = inventory.potionSlot[0]
	emit_signal("potionChanged", a)
#	print(emit_signal("potionChanged",a))
