class_name Teleport
extends Area2D

@export var teleport_to : String = "ZOMBIE"

func _ready() -> void:
	pass
	#SignalManager.connect("on_boss_defeated", appear)

func appear(_enemy: Enemy) -> void:
	print("APPPPEARR")
	visible = true
	$Sprite2D.visible = true
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		match teleport_to:
			"ZOMBIE":
				GameManager.change_scene(GameManager.ZOMBIE_LEVEL)
			"MAGE":
				GameManager.change_scene(GameManager.MAGE_LEVEL)
