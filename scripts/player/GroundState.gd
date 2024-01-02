extends State

class_name GroundState

@export var jump_velocity: float = -400.0
@export var air_state: State
@export var attack_state: State
@export var death_state: State


func state_process(delta):
	if !character.is_on_floor() and $"../../jump_out_of_time".is_stopped():
		next_state = air_state
	elif not death_state.change_scene:
		if character.health < 3:
			next_state = death_state

func state_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		jump()
	if event.is_action_pressed("attack"):
		attack()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
	
func attack():
	next_state = attack_state
	playback.travel("attack")

