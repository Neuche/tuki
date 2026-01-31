extends Panel

@onready var mask: TextureRect = $mask
@onready var area_2d: Area2D = $Area2D


func _get_drag_data(at_position: Vector2) -> Variant:
	if mask.texture == null:
		return; 
	var preview = duplicate()
	set_drag_preview(preview)
	return mask
	
# Called when the node enters the scene tree for the first time.

func _get_texture()-> Texture:
	return mask.texture

func _get_texture_position() -> Vector2:
	return mask.get_global_transform().origin
	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
