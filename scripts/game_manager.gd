extends Node

class_name GameManager

signal toggle_game_paused(is_paused: bool, is_death: bool)

var game_paused: Array[bool] = [false, false]:
	get:
		return game_paused
	set(value):
		game_paused = value
		emit_signal("toggle_game_paused", game_paused)
		get_tree().paused = game_paused[0]


func _input(event: InputEvent):
	if (event.is_action_pressed("ui_cancel")):
		game_paused = [!game_paused[0], game_paused[1]]
		
