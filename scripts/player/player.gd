extends CharacterBody2D

signal health_points(health: int)

@export var speed: float = 600.0
@export var health: int = 3:
	get:
		return health
	set(value):
		health = value
		SaveGame.game_data.HP = health
		SaveGame.save_data()
		emit_signal("health_points", health)

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: PlayerStateMachine = $player_state_machine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction: Vector2 = Vector2.ZERO
var leaved_floor: bool = false

func _ready():
	health = SaveGame.game_data.HP
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if not leaved_floor:
			$jump_out_of_time.start()
			leaved_floor = true
		velocity.y += gravity * delta
	else:
		leaved_floor = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && state_machine.check_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()

func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
