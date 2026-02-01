extends Panel

@export var item_texture: Texture2D

@onready var deco: TextureRect = $deco
@onready var area_2d: Area2D = $Area2D


func _get_drag_data(at_position: Vector2) -> Variant:
	if deco.texture == null:
		return; 
	var preview = duplicate()
	set_drag_preview(preview)
	return deco
	
# Called when the node enters the scene tree for the first time.

func _get_texture()-> Texture:
	return deco.texture

func _get_texture_position() -> Vector2:
	return deco.get_global_transform().origin
	
func _ready() -> void:
	if item_texture:
		deco.texture = item_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
