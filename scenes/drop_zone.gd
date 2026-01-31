extends Control

func _can_drop_data(_at_position, data):
	return data is TextureRect

func _drop_data(at_position, data):
	var new_texture = TextureRect.new()
	add_child(new_texture)
	
	new_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	new_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	var tamano_especifico = Vector2(100, 100)
	
	new_texture.texture = data.texture
	new_texture.custom_minimum_size = tamano_especifico
	new_texture.size = tamano_especifico
	
	# Center the texture on the mouse position (at_position is local to this control)
	new_texture.position = at_position - (new_texture.size / 2)
