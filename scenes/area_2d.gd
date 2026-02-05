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

		# Check if this is a base mask or a decoration
		var is_base_mask = false
		if current_source and "is_base_mask" in current_source:
			is_base_mask = current_source.is_base_mask

		if is_base_mask:
			# Replace the Mask sprite texture
			var mask_sprite = get_parent()
			if mask_sprite is Sprite2D:
				mask_sprite.texture = current_texture
		else:
			# Add decoration as a TextureRect child
			var new_texture_rect = TextureRect.new()
			add_child(new_texture_rect)

			#new_texture_rect.pivot_offset_ratio = Vector2(0.5, 0.5)

			new_texture_rect.texture = current_texture
			new_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
			var transform_texture : Vector2 = get_global_transform_with_canvas().get_scale()
			new_texture_rect.size = current_texture.get_size() / transform_texture
			
			new_texture_rect.position = Vector2.ZERO
			
			var mouse_pos = get_global_mouse_position()
			new_texture_rect.global_position = mouse_pos

		current_texture = null
		current_source = null
		
