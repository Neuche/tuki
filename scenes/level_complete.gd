extends Node2D

@onready var sprite = $AnimatedSprite
@onready var timer = $AnimationTimer

var frames = []
var current_frame = 0

func _ready():
	AudioManager.play_level_complete_music()

	# Load all the frames
	frames = [
		load("res://Assets/final/aa1.png"),
		load("res://Assets/final/aa2.png"),
		load("res://Assets/final/aa3.png"),
		load("res://Assets/final/aa4.png")
	]

	# Set initial frame
	if frames.size() > 0 and frames[0]:
		sprite.texture = frames[0]

	# Connect timer to cycle frames
	timer.timeout.connect(_on_animation_timer_timeout)

func _on_animation_timer_timeout():
	current_frame = (current_frame + 1) % frames.size()
	if frames[current_frame]:
		sprite.texture = frames[current_frame]
