extends Node2D

@onready var label = $Label
@onready var button_continue = $ButtonContinue
@onready var button_complete = $ButtonComplete

func _ready():
	actualizar_texto()
	actualizar_botones()

func _on_button_continue_pressed():
	GameState.incrementar_tarea()
	get_tree().change_scene_to_file("res://scenes/changuito_hello.tscn")

func _on_button_complete_pressed():
	get_tree().change_scene_to_file("res://scenes/level_complete.tscn")

func actualizar_texto():
	label.text = str(GameState.tareas_hechas) + "/" + str(GameState.tareas_objetivo)

func actualizar_botones():
	if GameState.estan_completas():
		button_continue.visible = false
		button_complete.visible = true
	else:
		button_continue.visible = true
		button_complete.visible = false
