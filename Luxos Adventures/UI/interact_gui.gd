extends Control

@onready var key = $CenterContainer/Panel/FKey

func _input(event):
	if event.is_action_pressed("interact"):
		key.frame = 1
	if event.is_action_released("interact"):
		key.frame = 0
