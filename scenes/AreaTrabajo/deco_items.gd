extends Panel

@onready var deco: TextureRect = $deco
@onready var area_2d: Area2D = $Area2D


func _get_drag_data(at_position: Vector2) -> Variant:
	if deco.texture == null:
		return null
	# Create a simple TextureRect preview instead of duplicating the whole Panel
	var preview = TextureRect.new()
	preview.texture = deco.texture
	preview.custom_minimum_size = size
	preview.size = size
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.modulate.a = 0.7
	set_drag_preview(preview)
	# Return the texture directly so we don't need to access it later through nodes
	return {"texture": deco.texture, "source": self}

func _get_texture()-> Texture:
	return deco.texture

func _get_texture_position() -> Vector2:
	if not is_inside_tree():
		return Vector2.ZERO
	return deco.get_global_transform().origin

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
