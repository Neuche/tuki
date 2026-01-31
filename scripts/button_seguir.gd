extends Button

func _pressed():
	GameState.reset_tareas()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
