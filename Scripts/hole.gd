extends Area2D

@export var scene_to_go : PackedScene 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.change_scene(GameManager.ZOMBIE_LEVEL)
		
