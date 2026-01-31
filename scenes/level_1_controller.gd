extends Node2D

func _on_finish_button_pressed():
	GameState.incrementar_tarea()
	get_tree().change_scene_to_file("res://scenes/changuito_hello.tscn")
