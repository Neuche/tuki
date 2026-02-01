extends Node2D

@onready var timer_label = $CanvasLayer/TimerLabel
var time_left = 10.0

func _ready():
	update_timer_display()

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		time_left = 0
		complete_level()
	update_timer_display()

func update_timer_display():
	timer_label.text = "Tiempo restante: " + str(int(ceil(time_left))) + "s"

func complete_level():
	GameState.incrementar_tarea()
	get_tree().change_scene_to_file("res://scenes/changuito_hello.tscn")

func _on_finish_button_pressed():
	complete_level()
