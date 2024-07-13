extends Control
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var button = $Button




func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Compact/playable_characters.tscn")
