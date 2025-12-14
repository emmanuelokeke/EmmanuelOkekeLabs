extends Node

var respawn_position: Vector2 = Vector2.ZERO
var respawn_health: int = 100

func set_checkpoint(position: Vector2, health_value: int) -> void:
	respawn_position = position
	respawn_health = health_value

func respawn_player(player: Node) -> void:
	if respawn_position == Vector2.ZERO:
		respawn_position = player.global_position

	player.global_position = respawn_position

	if player.has_node("Health"):
		var health_node = player.get_node("Health")
		health_node.current_health = respawn_health
		health_node.emit_signal("health_changed", health_node.current_health, health_node.max_health)

	if "can_control" in player:
		player.can_control = true
