class_name trail
extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


@export var base_damage: float = 100

func _on_despawn_timer_timeout() -> void:
	animation_player.play("despawn")
