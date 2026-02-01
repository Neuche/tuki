extends Area2D
# Called when the node enters the scene tree for the first tim
var current_drageable 
var new_texture 
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(drageable: Area2D) -> void:
	if drageable.is_in_group("dropeable"):
		current_drageable = drageable
		print("te vi")
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if(event.is_action_released("realese_left_click")):
		if current_drageable == null: return
		var new_texture = TextureRect.new()
		
		self.add_child(new_texture,false) 
		#tamaños
		new_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		new_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		var tamano_especifico = Vector2(100, 100)
		#fin de tamaño
		new_texture.texture = current_drageable.get_parent()._get_texture()
		var mouse_pos = get_global_mouse_position()
		new_texture.global_position = mouse_pos - (new_texture.size / 2)
		new_texture.custom_minimum_size = tamano_especifico
		new_texture.size = tamano_especifico
		
		current_drageable = null
		
