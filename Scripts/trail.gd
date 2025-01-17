class_name trail
extends Area2D

@export var base_damage: float = 100

func _on_despawn_timer_timeout() -> void:
	queue_free()
