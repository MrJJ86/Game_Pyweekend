extends Control

@export var game_manager: GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_game_paused)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_game_manager_game_paused(is_paused: Array[bool]):
	if is_paused[0] and is_paused[1]:
		show()
	else:
		hide()


func _on_regresar_pressed():
	game_manager.game_paused = [false, false]
	$"../../level_01/player/Camera2D".enabled = false
	get_tree().change_scene_to_file("res://scenes/game_manager.tscn")
