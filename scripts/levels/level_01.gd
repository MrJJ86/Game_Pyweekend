extends Node2D

@export var menu: Menu

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	menu.connect("change_scene", _on_change_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_change_scene(is_change: bool):
	if is_change:
		show()
	else:
		hide()
