extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
var gravity: float = 900.0

var can_control: bool = true

@onready var health: Node = $Health
@onready var damage_sfx: AudioStreamPlayer = $DamageSFX
@onready var death_sfx: AudioStreamPlayer = $DeathSFX

func _ready() -> void:
	# Connect death signal from Health
	health.died.connect(_on_health_died)

func _physics_process(delta: float) -> void:
	if not can_control:
		return

	# Horizontal move
	var dir := Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * speed

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_velocity

	move_and_slide()

func apply_damage(amount: int) -> void:
	if can_control:
		health.take_damage(amount)
		if damage_sfx.stream:
			damage_sfx.play()

func _on_health_died() -> void:
	can_control = false
	velocity = Vector2.ZERO
	if death_sfx.stream:
		death_sfx.play()
	await get_tree().create_timer(1.0).timeout
	GameManager.respawn_player(self)
