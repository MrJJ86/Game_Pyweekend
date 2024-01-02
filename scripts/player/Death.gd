extends State

@export var player: CharacterBody2D
@export var ground_state: State

var change_scene: bool = false

signal death_player(is_death: bool)

var is_death: bool = false:
	set(value):
		is_death = value
		emit_signal("death_player", is_death)

func _ready():
	player.connect("health_points", _on_player_health_points)


func _on_player_health_points(health: int):
	if health > 0:
		await get_tree().create_timer(0.4).timeout
		playback.travel("damage")
		await get_tree().create_timer(0.1).timeout
		next_state = ground_state
		is_death = false
		change_scene = true
		playback.travel("Move")
		
	elif health <= 0:
		change_scene = false
		await get_tree().create_timer(0.2).timeout
		playback.travel("death")
			

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "death":
		is_death = true
