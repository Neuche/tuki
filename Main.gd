extends Node2D

@export var decoration_scene: PackedScene

func _ready():
	$CanvasLayer/UI/Palette/StarBtn.pressed.connect(func(): spawn_decoration("res://assets/star.jpg"))
	$CanvasLayer/UI/Palette/HeartBtn.pressed.connect(func(): spawn_decoration("res://assets/heart.jpg"))
	$CanvasLayer/UI/Palette/DiamondBtn.pressed.connect(func(): spawn_decoration("res://assets/diamond.jpg"))

func spawn_decoration(texture_path: String):
	var deco = decoration_scene.instantiate()
	add_child(deco)
	deco.get_node("Sprite2D").texture = load(texture_path)
	deco.global_position = get_viewport_rect().size / 2
