extends Node2D

@onready var timer_label = $CanvasLayer/TimerLabel
var time_left = 10.0
var is_completing = false

func _ready():
	update_timer_display()

func _process(delta):
	time_left -= delta
	if time_left <= 0 and not is_completing:
		time_left = 0
		is_completing = true
		complete_level()
	update_timer_display()

func update_timer_display():
	timer_label.text = "Tiempo restante: " + str(int(ceil(time_left))) + "s"

func complete_level():
	# Capture mask snapshot
	var mask_image = await capture_mask_snapshot()

	# Store in GameState with requesting character
	GameState.store_mask_capture(mask_image, GameState.requesting_character_index)

	# Increment task counter
	GameState.incrementar_tarea()

	# Transition to delivery scene
	get_tree().change_scene_to_file("res://scenes/changuito_hello.tscn")

func capture_mask_snapshot() -> Image:
	# Create SubViewport for transparent rendering
	var viewport = SubViewport.new()
	viewport.transparent_bg = true
	viewport.size = Vector2(512, 512)
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	add_child(viewport)

	# Get mask node and duplicate with all decorations
	var mask_node = $Mask
	var mask_copy = mask_node.duplicate(DUPLICATE_SCRIPTS | DUPLICATE_SIGNALS)
	viewport.add_child(mask_copy)

	# Center the mask in viewport and scale down to show full silhouette
	mask_copy.position = viewport.size / 2
	mask_copy.scale = Vector2(0.4, 0.4)

	# Wait for multiple frames to ensure rendering completes
	await get_tree().process_frame
	await get_tree().process_frame
	await RenderingServer.frame_post_draw

	# Get image
	var img = viewport.get_texture().get_image()

	# Cleanup
	viewport.queue_free()

	return img

func _on_finish_button_pressed():
	complete_level()
