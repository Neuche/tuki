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
	if drageable.is_in_group("dropable"):
		current_drageable = drageable
		print("te vi")
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	pass

		
