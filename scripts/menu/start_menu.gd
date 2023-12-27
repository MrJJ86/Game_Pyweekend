extends Control

var GLOBAL = "res://scripts/GLOBAL.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bt_exit_pressed():
	get_tree().quit()


func _on_bt_settings_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/settings.tscn")


func _on_bt_start_pressed():
	pass # Replace with function body.
