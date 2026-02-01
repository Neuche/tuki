extends Node

# Global game state that persists across scenes
var tareas_hechas: int = 0
var tareas_objetivo: int = 1

# Mask capture state
var captured_mask_image: Image = null
var requesting_character_index: int = -1
var requesting_character_type: String = ""
var is_delivery_mode: bool = false

func reset_tareas():
	tareas_hechas = 0

func incrementar_tarea():
	tareas_hechas += 1

func estan_completas() -> bool:
	return tareas_hechas >= tareas_objetivo

func store_mask_capture(image: Image, character_idx: int, character_type: String = ""):
	captured_mask_image = image
	requesting_character_index = character_idx
	requesting_character_type = character_type
	is_delivery_mode = true

func get_captured_mask() -> Image:
	return captured_mask_image

func clear_mask_data():
	captured_mask_image = null
	is_delivery_mode = false
	requesting_character_type = ""
	# Keep requesting_character_index for one more cycle
