extends State

class_name AirState

@export var landing_state: State
@export var ground_state: State
@export var death_state: State


func state_process(delta):
	if character.is_on_floor():
		next_state = landing_state
	elif not $"../../jump_out_of_time".is_stopped():
		next_state = ground_state

func on_exit():
	if next_state == landing_state:
		playback.travel("jump_end")


