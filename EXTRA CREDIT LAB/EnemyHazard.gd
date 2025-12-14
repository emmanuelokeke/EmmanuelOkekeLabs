extends Area2D

@export var speed: float = 80.0
@export var left_limit: float = -100.0
@export var right_limit: float = 100.0
@export var damage_amount: int = 20

signal damaged(target: Node, amount: int)

var direction: int = 1
var start_position: Vector2

func _ready() -> void:
	start_position = global_position
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	global_position.x += speed * direction * delta

	var offset_x = global_position.x - start_position.x
	if offset_x > right_limit:
		direction = -1
	elif offset_x < left_limit:
		direction = 1

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("damageable"):
		emit_signal("damaged", body, damage_amount)
