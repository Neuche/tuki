extends Node2D

@onready var changuito_sprite = $Sprite2D
@onready var mask_overlay: Sprite2D = $MaskOverlay

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

var current_character_index: int = -1

func _ready() -> void:
	if GameState.is_delivery_mode:
		handle_delivery_mode()
	else:
		handle_request_mode()

func handle_request_mode():
	# Select random character
	current_character_index = randi() % changuitos.size()
	var selected = changuitos[current_character_index]

	# Store in GameState for later delivery
	GameState.requesting_character_index = current_character_index

	# Show character and dialog
	changuito_sprite.texture = selected.texture

	# Start the dialog for the selected changuito
	Dialogic.start(selected.timeline)

	# Connect to dialog end signal
	Dialogic.timeline_ended.connect(_on_request_dialog_ended)

func handle_delivery_mode() -> void:
	# Show the character who requested the mask
	current_character_index = GameState.requesting_character_index
	var grateful_character = changuitos[current_character_index]
	changuito_sprite.texture = grateful_character.texture

	# Apply captured mask to character's face
	var mask_image = GameState.get_captured_mask()
	if mask_image:
		var mask_texture = ImageTexture.create_from_image(mask_image)
		mask_overlay.texture = mask_texture
		mask_overlay.visible = true

	# Play gratitude dialog
	Dialogic.start("res://dialogic/timelines/gratitude.dtl")
	Dialogic.timeline_ended.connect(_on_gratitude_dialog_ended)

func _on_gratitude_dialog_ended():
	# Cleanup
	await get_tree().process_frame
	await get_tree().process_frame

	# Wait 3 seconds
	await get_tree().create_timer(3.0).timeout

	# Hide mask
	mask_overlay.visible = false

	# Select NEW character (different from current)
	var new_index = (current_character_index + 1 + randi() % 2) % 3
	current_character_index = new_index
	GameState.requesting_character_index = new_index

	var new_character = changuitos[new_index]
	changuito_sprite.texture = new_character.texture

	# Clear delivery mode and mask data
	GameState.clear_mask_data()

	# Play new request dialog
	Dialogic.timeline_ended.disconnect(_on_gratitude_dialog_ended)
	Dialogic.start(new_character.timeline)
	Dialogic.timeline_ended.connect(_on_request_dialog_ended)

func _on_request_dialog_ended():
	# Wait for the next frame to ensure Dialogic's async cleanup is complete
	# Dialogic's clean() function uses `await Engine.get_main_loop().process_frame`
	# so we need to wait for that to finish before changing scenes
	await get_tree().process_frame
	await get_tree().process_frame # Wait an extra frame to be safe

	if GameState.estan_completas():
		get_tree().change_scene_to_file("res://scenes/level_complete.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
