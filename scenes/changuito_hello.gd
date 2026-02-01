extends Node2D

@onready var sprite_adulto: Sprite2D = $Sprite2DAdulto
@onready var sprite_chico: Sprite2D = $Sprite2DChico
@onready var sprite_viejo: Sprite2D = $Sprite2DViejo
@onready var mask_overlay_adulto: Sprite2D = $MaskOverlayAdulto
@onready var mask_overlay_chico: Sprite2D = $MaskOverlayChico
@onready var mask_overlay_viejo: Sprite2D = $MaskOverlayViejo

# Preload all textures at compile time
const ADULTO1_TEXTURE = preload("res://Assets/Changos/adulto1.png")
const ADULTO2_TEXTURE = preload("res://Assets/Changos/adulto2.png")
const ADULTO3_TEXTURE = preload("res://Assets/Changos/adulto3.png")
const ADULTO4_TEXTURE = preload("res://Assets/Changos/adulto4.png")
const ADULTO5_TEXTURE = preload("res://Assets/Changos/adulto5.png")
const ADULTO6_TEXTURE = preload("res://Assets/Changos/adulto6.png")
const CHICO1_TEXTURE = preload("res://Assets/Changos/chico1.png")
const CHICO2_TEXTURE = preload("res://Assets/Changos/chico2.png")
const CHICO3_TEXTURE = preload("res://Assets/Changos/chico3.png")
const VIEJO1_TEXTURE = preload("res://Assets/Changos/viejo1.png")
const VIEJO2_TEXTURE = preload("res://Assets/Changos/viejo2.png")
const VIEJO3_TEXTURE = preload("res://Assets/Changos/viejo3.png")

# Data for each changuito
var changuitos = [
	{
		"character": "res://dialogic/characters/adulto1.dch",
		"timeline": "res://dialogic/timelines/adulto1_dialog.dtl",
		"texture": ADULTO1_TEXTURE,
		"type": "adulto"
	},
	{
		"character": "res://dialogic/characters/adulto2.dch",
		"timeline": "res://dialogic/timelines/adulto2_dialog.dtl",
		"texture": ADULTO2_TEXTURE,
		"type": "adulto"
	},
	{
		"character": "res://dialogic/characters/adulto3.dch",
		"timeline": "res://dialogic/timelines/adulto3_dialog.dtl",
		"texture": ADULTO3_TEXTURE,
		"type": "adulto"
	},
	{
		"character": "res://dialogic/characters/adulto4.dch",
		"timeline": "res://dialogic/timelines/adulto4_dialog.dtl",
		"texture": ADULTO4_TEXTURE,
		"type": "adulto"
	},
	{
		"character": "res://dialogic/characters/adulto5.dch",
		"timeline": "res://dialogic/timelines/adulto5_dialog.dtl",
		"texture": ADULTO5_TEXTURE,
		"type": "adulto"
	},
	{
		"character": "res://dialogic/characters/adulto6.dch",
		"timeline": "res://dialogic/timelines/adulto6_dialog.dtl",
		"texture": ADULTO6_TEXTURE,
		"type": "adulto"
	},
	{
		"character": "res://dialogic/characters/chico1.dch",
		"timeline": "res://dialogic/timelines/chico1_dialog.dtl",
		"texture": CHICO1_TEXTURE,
		"type": "chico"
	},
	{
		"character": "res://dialogic/characters/chico2.dch",
		"timeline": "res://dialogic/timelines/chico2_dialog.dtl",
		"texture": CHICO2_TEXTURE,
		"type": "chico"
	},
	{
		"character": "res://dialogic/characters/chico3.dch",
		"timeline": "res://dialogic/timelines/chico3_dialog.dtl",
		"texture": CHICO3_TEXTURE,
		"type": "chico"
	},
	{
		"character": "res://dialogic/characters/viejo1.dch",
		"timeline": "res://dialogic/timelines/viejo1_dialog.dtl",
		"texture": VIEJO1_TEXTURE,
		"type": "viejo"
	},
	{
		"character": "res://dialogic/characters/viejo2.dch",
		"timeline": "res://dialogic/timelines/viejo2_dialog.dtl",
		"texture": VIEJO2_TEXTURE,
		"type": "viejo"
	},
	{
		"character": "res://dialogic/characters/viejo3.dch",
		"timeline": "res://dialogic/timelines/viejo3_dialog.dtl",
		"texture": VIEJO3_TEXTURE,
		"type": "viejo"
	}
]

var current_character_index: int = -1

func _ready() -> void:
	AudioManager.play_gameplay_music()

	# Debug: Print mask overlay positions
	print("MaskOverlayAdulto position: ", mask_overlay_adulto.position)
	print("MaskOverlayChico position: ", mask_overlay_chico.position)
	print("MaskOverlayViejo position: ", mask_overlay_viejo.position)

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
	GameState.requesting_character_type = selected.type

	# Show only the sprite for the character type
	sprite_adulto.visible = false
	sprite_chico.visible = false
	sprite_viejo.visible = false

	match selected.type:
		"adulto":
			sprite_adulto.texture = selected.texture
			sprite_adulto.visible = true
		"chico":
			sprite_chico.texture = selected.texture
			sprite_chico.visible = true
		"viejo":
			sprite_viejo.texture = selected.texture
			sprite_viejo.visible = true

	# Start the dialog for the selected changuito
	Dialogic.start(selected.timeline)

	# Connect to dialog end signal
	Dialogic.timeline_ended.connect(_on_request_dialog_ended)

func handle_delivery_mode() -> void:
	# Show the character who requested the mask
	current_character_index = GameState.requesting_character_index
	var grateful_character = changuitos[current_character_index]

	# Show only the sprite for the character type
	sprite_adulto.visible = false
	sprite_chico.visible = false
	sprite_viejo.visible = false

	match grateful_character.type:
		"adulto":
			sprite_adulto.texture = grateful_character.texture
			sprite_adulto.visible = true
		"chico":
			sprite_chico.texture = grateful_character.texture
			sprite_chico.visible = true
		"viejo":
			sprite_viejo.texture = grateful_character.texture
			sprite_viejo.visible = true

	# Apply captured mask to character's face - show only the type-specific overlay
	var mask_image = GameState.get_captured_mask()
	if mask_image:
		var mask_texture = ImageTexture.create_from_image(mask_image)

		# Hide all overlays first
		mask_overlay_adulto.visible = false
		mask_overlay_chico.visible = false
		mask_overlay_viejo.visible = false

		# Show only the overlay for the character type
		var character_type = GameState.requesting_character_type
		match character_type:
			"adulto":
				mask_overlay_adulto.texture = mask_texture
				mask_overlay_adulto.visible = true
			"chico":
				mask_overlay_chico.texture = mask_texture
				mask_overlay_chico.visible = true
			"viejo":
				mask_overlay_viejo.texture = mask_texture
				mask_overlay_viejo.visible = true
			_:
				# Fallback to adulto
				mask_overlay_adulto.texture = mask_texture
				mask_overlay_adulto.visible = true

	# Play gratitude dialog
	Dialogic.start("res://dialogic/timelines/gratitude.dtl")
	Dialogic.timeline_ended.connect(_on_gratitude_dialog_ended)

func _on_gratitude_dialog_ended():
	# Cleanup
	await get_tree().process_frame
	await get_tree().process_frame

	# Disconnect signal first
	Dialogic.timeline_ended.disconnect(_on_gratitude_dialog_ended)

	# Check if all tasks are complete - go to level complete without spawning new character
	if GameState.estan_completas():
		GameState.clear_mask_data()
		get_tree().change_scene_to_file("res://scenes/level_complete.tscn")
		return

	# Wait 3 seconds
	await get_tree().create_timer(0.1).timeout

	# Hide all masks
	mask_overlay_adulto.visible = false
	mask_overlay_chico.visible = false
	mask_overlay_viejo.visible = false

	# Select NEW character (different from current)
	var new_index = current_character_index
	while new_index == current_character_index:
		new_index = randi() % changuitos.size()

	current_character_index = new_index
	GameState.requesting_character_index = new_index

	var new_character = changuitos[new_index]
	GameState.requesting_character_type = new_character.type

	# Show only the sprite for the new character type
	sprite_adulto.visible = false
	sprite_chico.visible = false
	sprite_viejo.visible = false

	match new_character.type:
		"adulto":
			sprite_adulto.texture = new_character.texture
			sprite_adulto.visible = true
		"chico":
			sprite_chico.texture = new_character.texture
			sprite_chico.visible = true
		"viejo":
			sprite_viejo.texture = new_character.texture
			sprite_viejo.visible = true

	# Clear delivery mode and mask data
	GameState.clear_mask_data()

	# Play new request dialog
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
