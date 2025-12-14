extends Node

@export var max_health: int = 100
var current_health: int

signal health_changed(current_health: int, max_health: int)
signal died

func _ready() -> void:
	current_health = max_health
	emit_signal("health_changed", current_health, max_health)

func take_damage(amount: int) -> void:
	if amount <= 0 or current_health <= 0:
		return

	current_health = max(current_health - amount, 0)
	emit_signal("health_changed", current_health, max_health)

	if current_health == 0:
		emit_signal("died")

func heal(amount: int) -> void:
	if amount <= 0 or current_health <= 0:
		return

	current_health = clamp(current_health + amount, 0, max_health)
	emit_signal("health_changed", current_health, max_health)

func reset_full() -> void:
	current_health = max_health
	emit_signal("health_changed", current_health, max_health)
