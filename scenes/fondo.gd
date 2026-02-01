extends Sprite2D

func _ready():
	ajustar_a_pantalla()
	# Play menu music if we're in the menu scene
	if get_tree().current_scene.name == "Menu":
		AudioManager.play_menu_music()

func ajustar_a_pantalla():
	var screen_size = get_viewport_rect().size
	var texture_size = texture.get_size()

	var scale_x = screen_size.x / texture_size.x
	var scale_y = screen_size.y / texture_size.y

	var escala = max(scale_x, scale_y)

	scale = Vector2(escala, escala)
	position = screen_size / 2
