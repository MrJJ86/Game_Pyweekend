extends ParallaxBackground

@export var speed_parallax: Vector2 = Vector2(50,50)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset -= speed_parallax * delta
	
