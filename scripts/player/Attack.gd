extends State

@export var return_state: State
@export var death_state: State

@onready var timer: Timer = $Timer


func state_input(event: InputEvent):
	if event.is_action_pressed("attack"):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack":
		if timer.is_stopped():
			next_state = return_state
			playback.travel("Move")

