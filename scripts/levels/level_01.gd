extends Node2D

@export var menu: Menu
@export var player: CharacterBody2D
@export var game_manager: GameManager

@onready var current_checkpoint: Array[Area2D] = [$Checkpoints/checkpoint_1, $Checkpoints/checkpoint_2, $Checkpoints/checkpoint_3, $Checkpoints/checkpoint_4]
@onready var death_state: State = $player/player_state_machine/Death

@export var initial_position: Vector2 = Vector2(100,150)

var is_platform_moving: bool = false
var is_platform_up: bool = false

var number: int = 0

func _ready():
	SaveGame.load_data()
	var number_checkpoint = SaveGame.game_data.CHECKPOINT
	
	if number_checkpoint > 0:
		$player.position = current_checkpoint[number_checkpoint -1].position
		
	else:
		$player.position = initial_position
		
	hide()
	menu.connect("change_scene", _on_change_scene)
	death_state.connect("death_player", _on_death_player)

#
func _on_change_scene(is_change: bool):
	if is_change:
		show()
		$player/Camera2D.enabled = true
	else:
		hide()

func _on_death_player(is_death:bool):
	if is_death:
		print(is_death)
		SaveGame.game_data.CHECKPOINT = 0
		SaveGame.game_data.HP = 3
		SaveGame.save_data()
		await get_tree().create_timer(0.5).timeout
		game_manager.game_paused = [true, true]

func save_checkpoint(number: int):
	SaveGame.game_data.HP = $player.health
	SaveGame.game_data.CHECKPOINT = number
	SaveGame.save_data()

#-------------SIGNALS-----------------

#Checkpoints
func _on_out_side_1_body_entered(body):
	$player.position = current_checkpoint[number -1].position
	$player.health -= 1
	print("Outside 1")

func _on_checkpoint_1_body_entered(body):
	number = 1
	save_checkpoint(number)
	print("Enter on check1")

func _on_checkpoint_2_body_entered(body):
	number = 2
	save_checkpoint(number)
	print("Enter on check2")
	$Obstacule_road/Animation_obstacule.play("RESET")
	
func _on_checkpoint_3_body_entered(body):
	number = 3
	save_checkpoint(number)
	print("Enter on check3")


func _on_checkpoint_4_body_entered(body):
	number = 4
	save_checkpoint(number)
	print("Enter on check4")

#Obstacule road	

func _on_detected_start_anim_body_entered(body):
	await get_tree().create_timer(1).timeout
	$Obstacule_road/Animation_obstacule.play("obstacule")

func _on_detected_finish_anim_body_entered(body):
	await get_tree().create_timer(2).timeout
	$Obstacule_road/Animation_obstacule.pause()

func _on_detected_finish_anim_body_exited(body):
	$Obstacule_road/Animation_obstacule.play("obstacule")
	await get_tree().create_timer(10).timeout
	$Obstacule_road/Animation_obstacule.play("RESET")
	$Obstacule_road/detected_finish_anim.visible = false

func _on_moving_saw_blade_body_entered(body):
	$player.position = current_checkpoint[number -1].position
	$player.health -= 1

# Elevator
func _on_detected_platform_start_body_entered(body):
	if not is_platform_moving and not is_platform_up:
		$path_platform_1/PathFollow2D/Animation_platform.play("up")

func _on_detected_platform_reset_body_entered(body):
	await $path_platform_1/PathFollow2D/Animation_platform.animation_finished
	if not is_platform_moving and is_platform_up:
		$path_platform_1/PathFollow2D/Animation_platform.play("down")

func _on_detected_platform_reset_body_exited(body):
	if not is_platform_moving and not is_platform_up:
		$path_platform_1/PathFollow2D/Animation_platform.play("RESET")

func _on_animation_platform_animation_finished(anim_name):
	is_platform_moving = false
	
	if anim_name == "up":
		is_platform_up = true
	elif anim_name == "down":
		is_platform_up = false

func _on_animation_platform_animation_started(anim_name):
	is_platform_moving = true


#Pillars

func _on_moving_pillars_set_1_body_entered(body):
	$moving_pillars_set_1/AnimationPlayer.play("pillars_set_1")

func _on_moving_pillars_set_1_body_exited(body):
	$moving_pillars_set_1/AnimationPlayer.play("RESET")

func _on_moving_pilllars_set_2_body_entered(body):
	$moving_pillars_set_2/AnimationPlayer.play("pillars_set_2")

func _on_moving_pilllars_set_2_body_exited(body):
	$moving_pillars_set_2/AnimationPlayer.play("RESET")

