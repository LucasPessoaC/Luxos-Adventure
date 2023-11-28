extends Control


@export var mainGameScene : PackedScene

@onready var audio_stream_player = $AudioStreamPlayer

func _on_new_game_button_button_up():
	get_tree().change_scene_to_file("res://Levels/game_level___initial_area.tscn")


func _on_quit_button_button_up():
	get_tree().quit()
