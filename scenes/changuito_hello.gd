extends Node2D

@onready var changuito_sprite = $Sprite2D

# Preload all textures at compile time
const CHANGUITO1_TEXTURE = preload("res://Assets/changuito1.png")
const CHANGUITO2_TEXTURE = preload("res://Assets/changuito2.png")
const CHANGUITO3_TEXTURE = preload("res://Assets/changuito3.png")

# Data for each changuito
var changuitos = [
	{
		"character": "res://dialogic/characters/changuito.dch",
		"timeline": "res://dialogic/timelines/hello.dtl",
		"texture": CHANGUITO1_TEXTURE
	},
	{
		"character": "res://dialogic/characters/changuito2.dch",
		"timeline": "res://dialogic/timelines/changuito2_dialog.dtl",
		"texture": CHANGUITO2_TEXTURE
	},
	{
		"character": "res://dialogic/characters/changuito3.dch",
		"timeline": "res://dialogic/timelines/changuito3_dialog.dtl",
		"texture": CHANGUITO3_TEXTURE
	}
]

func _ready() -> void:
	# Select a random changuito
	var selected = changuitos[randi() % changuitos.size()]

	# Update the sprite to show the selected changuito
	changuito_sprite.texture = selected.texture
	print("Loaded changuito texture")

	# Start the dialog for the selected changuito
	Dialogic.start(selected.timeline)

	# Connect to dialog end signal
	Dialogic.timeline_ended.connect(_on_dialog_ended)

func _on_dialog_ended():
	# Wait for the next frame to ensure Dialogic's async cleanup is complete
	# Dialogic's clean() function uses `await Engine.get_main_loop().process_frame`
	# so we need to wait for that to finish before changing scenes
	await get_tree().process_frame
	await get_tree().process_frame # Wait an extra frame to be safe
	
	if GameState.estan_completas():
		get_tree().change_scene_to_file("res://scenes/level_complete.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
