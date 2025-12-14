extends CanvasLayer

@onready var health_bar: ProgressBar = $HealthBar
@onready var damage_flash: ColorRect = $DamageFlash

func connect_to_health(health_node: Node) -> void:
	health_node.health_changed.connect(_on_health_changed)
	_on_health_changed(health_node.current_health, health_node.max_health)

func _on_health_changed(current: int, max: int) -> void:
	health_bar.max_value = max
	health_bar.value = current

func show_damage_flash() -> void:
	damage_flash.modulate.a = 0.6
	var tween := create_tween()
	tween.tween_property(damage_flash, "modulate:a", 0.0, 0.25)
