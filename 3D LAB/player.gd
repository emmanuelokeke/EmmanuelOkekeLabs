extends CharacterBody3D

@export var speed = 5.0
@export var mouse_sensitivity = 0.003
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera_pivot = $CameraPivot

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-45), deg_to_rad(45))

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Move forward only while Space is pressed
	if Input.is_action_pressed("ui_accept"):
		var forward = -transform.basis.z
		velocity.x = forward.x * speed
		velocity.z = forward.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
