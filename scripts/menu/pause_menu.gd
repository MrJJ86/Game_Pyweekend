extends Control

class_name PauseMenu

@export var game_manager: GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_game_paused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_game_manager_game_paused(is_paused: bool):
	if (is_paused):
		show()
	else:
		hide()


func _on_bt_reanudar_pressed():
	game_manager.game_paused = false



func _on_bt_regresar_pressed():
	game_manager.game_paused = false
	$"../../level_01/player/Camera2D".enabled = false
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")
