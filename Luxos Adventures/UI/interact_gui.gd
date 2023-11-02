extends Control

@onready var key = $CenterContainer/Panel/FKey
signal interagir
func _ready():
	visible = false

func _input(event):
	if (event.is_action_pressed("interact") && visible == true):
		key.frame = 1
		emit_signal("interagir")
	if (event.is_action_released("interact") && visible == true):
		key.frame = 0
#		emit_signal("interagir")
		


func _on_door_activate_gui():
	visible = true


func _on_door_deactivate_gui():
	visible = false
