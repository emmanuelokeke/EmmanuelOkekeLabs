extends Sprite2D

@export var health = 10
@export var booleanVar = true

@export var speed = 5.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

#called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_right"):
		position.x += speed
		print("haha")
