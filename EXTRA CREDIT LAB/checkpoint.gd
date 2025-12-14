extends Area2D

var active: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if active:
		return

	if body.name == "Player" and body.has_node("Health"):
		active = true
		var health_node = body.get_node("Health")
		GameManager.set_checkpoint(global_position, health_node.current_health)
		_show_checkpoint_feedback()

func _show_checkpoint_feedback() -> void:
	# Simple visual: tint sprite green
	if has_node("Sprite2D"):
		$Sprite2D.modulate = Color(0.6, 1.0, 0.6)
