extends Node2D

@onready var sprite = $StaticBody2D/Sprite2D
@onready var collision = $StaticBody2D/CollisionShape2D
signal activateGUI
signal deactivateGUI


func _on_activation_range_body_entered(body):
	if(body.name == "Player_Main"):
		emit_signal("activateGUI")

func _process(delta):
	if(sprite.frame == 1):
		collision.disabled = true
	else:
		collision.disabled = false
		

func _on_interact_gui_interagir():
	if(sprite.frame == 1):
		sprite.frame = 0
	else:
		sprite.frame = 1
		


func _on_activation_range_body_exited(body):
	emit_signal("deactivateGUI")
