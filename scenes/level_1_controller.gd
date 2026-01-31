extends Node2D

func _on_finish_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level_complete.tscn")
