extends Area2D

@export var trap_damage: float = 25

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(trap_damage)
