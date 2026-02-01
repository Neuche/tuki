extends Area2D

var current_texture: Texture = null
var current_source: Node = null

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_area_entered(drageable: Area2D) -> void:
	if drageable.is_in_group("dropeable"):
		var parent = drageable.get_parent()
		if parent.has_method("_get_texture"):
			current_texture = parent._get_texture()
			current_source = parent

func _on_area_exited(drageable: Area2D) -> void:
	if drageable.is_in_group("dropeable"):
		var parent = drageable.get_parent()
		if parent == current_source:
			current_texture = null
			current_source = null

func _input(event: InputEvent) -> void:
	if event.is_action_released("realese_left_click"):
		if current_texture == null:
			return

		var new_texture_rect = TextureRect.new()
		add_child(new_texture_rect)

		new_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		new_texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		var tamano_especifico = Vector2(100, 100)

		new_texture_rect.texture = current_texture
		var mouse_pos = get_global_mouse_position()
		new_texture_rect.global_position = mouse_pos - (tamano_especifico / 2)
		new_texture_rect.custom_minimum_size = tamano_especifico
		new_texture_rect.size = tamano_especifico

		current_texture = null
		current_source = null
		
