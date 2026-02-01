extends Panel

@onready var deco: TextureRect = $deco
@onready var area_2d: Area2D = $Area2D

@export var is_base_mask: bool = false


func _get_drag_data(at_position: Vector2) -> Variant:
	if deco.texture == null:
		return null

	# Make the Area2D follow the mouse during drag
	area_2d.set_meta("dragging", true)

	# Create a simple visual preview
	var preview = TextureRect.new()
	preview.texture = deco.texture
	preview.custom_minimum_size = size
	preview.size = size
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.modulate.a = 0.7
	# Offset so the preview is centered on the cursor
	preview.position = -size / 2

	set_drag_preview(preview)
	# Return the texture and whether it's a base mask
	return {"texture": deco.texture, "source": self, "is_base_mask": is_base_mask}

func _process(delta: float) -> void:
	# Move Area2D to follow mouse cursor during drag
	if area_2d.has_meta("dragging") and area_2d.get_meta("dragging"):
		area_2d.global_position = get_global_mouse_position()

func _notification(what: int) -> void:
	# Clean up when drag ends
	if what == NOTIFICATION_DRAG_END:
		if area_2d.has_meta("dragging"):
			area_2d.remove_meta("dragging")
			area_2d.position = Vector2.ZERO

func _get_texture()-> Texture:
	return deco.texture

func _get_texture_position() -> Vector2:
	if not is_inside_tree():
		return Vector2.ZERO
	return deco.get_global_transform().origin
