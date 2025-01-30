class_name Teleport
extends Area2D

@export var teleport_to : String = "ZOMBIE"
@onready var collision_shape: CollisionShape2D = $CollisionShape2D



func _ready() -> void:
	SignalManager.connect("on_boss_defeated", appear)

func appear(_enemy: Enemy) -> void:
	call_deferred("appear_defered")

func appear_defered() -> void:
	print("APPPPEARR")
	visible = true
	$Sprite2D.visible = true
	$CollisionShape2D.disabled = false


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		
		print("Body local: ",body.position)
		print("Body global: ",body.global_position)
		
		print("Teleport local: ", position)
		print("Teleport global: ", global_position)
		
		body.animation_player.play("shrink")
		body.can_move = false
		body.velocity = Vector2.ZERO
		body.position = collision_shape.global_position 
		
		await body.animation_player.animation_finished
		match teleport_to:
			"ZOMBIE":
				GameManager.change_scene(load("res://Scenes/Level/zombie_level.tscn"))
			"MAGE":
				GameManager.change_scene(load("res://Scenes/Level/mage_level.tscn"))
			"ORC":
				GameManager.change_scene(load("res://Scenes/Level/OrcBoss_Level.tscn"))
			"END":
				GameManager.change_scene(load("res://Scenes/UI/thanks_for_playing.tscn"))
			"MENU":
				GameManager.change_main_scene()
