extends Control

class_name Menu
@export var game_manager: GameManager


var scene: bool = false:
	get:
		return scene
	set(value):
		scene = value
		emit_signal("change_scene", scene)

signal change_scene(is_change: bool)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bt_exit_pressed():
	get_tree().quit()


func _on_bt_settings_pressed():
	game_manager.game_paused = true


func _on_bt_start_pressed():
	hide()
	$bg_menu.hide()
	scene = true
