extends Node2D

var hechas = 0
var objetivo = 3

@onready var label = $Label

func _ready():
	actualizar_texto()

func _on_button_pressed():
	hechas +=1
	actualizar_texto()
	if hechas == objetivo:
		nivel_completado()

func actualizar_texto():
	label.text = str(hechas) + "/" + str(objetivo)

func nivel_completado():
	get_tree().change_scene_to_file("res://scenes/level_complete.tscn")
