extends Node2D

const TUTORIAL_ENEMY = preload("res://Scenes/Enemy/tutorial_enemy.tscn")
@onready var music: AudioStreamPlayer = $Music

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1.0
	SignalManager.connect("on_tutorial_died",_on_tutorial_enemy_on_tutorial_enemy_died )
	SignalManager.connect("on_boss_defeated",stop_music)


func _on_tutorial_enemy_on_tutorial_enemy_died() -> void:
	call_deferred("respawn_tutorial_enemy")

func stop_music(enemy : Enemy) -> void:
	var tween = create_tween()
	tween.tween_property(music,"volume_db", -1000, 100)

func respawn_tutorial_enemy() -> void:
	var new_enemy : Enemy = TUTORIAL_ENEMY.instantiate()
	new_enemy.global_position = Vector2(0,225)
	$Entities.add_child(new_enemy)
	
