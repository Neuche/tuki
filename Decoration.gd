extends Area2D

var dragging = false
var offset = Vector2.ZERO

func _ready():
	input_pickable = true
	# Ensure the collision shape matches the sprite size if possible
	# For simplicity, we'll just use the default set in the scene

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				offset = global_position - get_global_mouse_position()
				# Bring to front
				z_index = 10
			else:
				dragging = false
				z_index = 0

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() + offset
