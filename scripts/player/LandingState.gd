extends State

@export var landing_animaiton_name: String = "landing"
@export var ground_state: State
@export var death_state: State


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == landing_animaiton_name:
		next_state = ground_state

