extends Area2D


@export var heal_ammount: float = 100


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		set_process(false)
		body.heal(heal_ammount)
		queue_free()
