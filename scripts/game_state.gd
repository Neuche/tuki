extends Node

# Global game state that persists across scenes
var tareas_hechas: int = 0
var tareas_objetivo: int = 3

func reset_tareas():
	tareas_hechas = 0

func incrementar_tarea():
	tareas_hechas += 1

func estan_completas() -> bool:
	return tareas_hechas >= tareas_objetivo
