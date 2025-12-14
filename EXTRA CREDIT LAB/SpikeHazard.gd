extends Area2D

@export var damage_amount: int = 25
signal damaged(target: Node, amount: int)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("damageable"):
		emit_signal("damaged", body, damage_amount)
