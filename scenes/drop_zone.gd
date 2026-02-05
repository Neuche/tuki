extends Control

func _can_drop_data(_at_position, data):
	return data is TextureRect

func _drop_data(at_position, data):
	"""
	ESTA FUNCION PARECE NO LLAMARSE NUNCA??
	
	var new_texture = TextureRect.new()
	add_child(new_texture)
	
	new_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	new_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	var tex_size = data["texture"].get_size()
	new_texture.custom_minimum_size = Vector2.ZERO
	new_texture.size_flags_horizontal = 0
	new_texture.size_flags_vertical = 0
	new_texture.size = tex_size * Vector2(0.5,0.5)
	
	# Center the texture on the mouse position (at_position is local to this control)
	new_texture.position = at_position - (new_texture.size / 2)
	"""
