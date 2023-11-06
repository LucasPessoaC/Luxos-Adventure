extends Control

class_name transitor

@export var scene_to_load: PackedScene = preload("res://UI/MainMenu.tscn")

@onready var texture = $TextureRect
@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	texture.visible = false


func set_next_animation(fading_out: bool):
	if(fading_out):
		animation.queue("fade_out")
	else:
		animation.queue("fade_in")


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "fade_out" ):
#		get_tree().reload_current_scene()
		get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
		
