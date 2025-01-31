extends Node2D

const TUTORIAL_ENEMY = preload("res://Scenes/Enemy/tutorial_enemy.tscn")
const RUNNING_RETRO = preload("res://Assets/sounds/Running Retro.mp3")

@onready var music: AudioStreamPlayer = $Music
@onready var music_restart_timer: Timer = $MusicRestartTimer
@onready var entities: Node = $Entities
@onready var projectile_container: Node = $ProjectileContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1.0
	SignalManager.connect("on_tutorial_died",_on_tutorial_enemy_on_tutorial_enemy_died )
	SignalManager.connect("on_boss_defeated",stop_music)
	SignalManager.connect("on_boss_defeated",delete_projectiles)


func _on_tutorial_enemy_on_tutorial_enemy_died() -> void:
	call_deferred("respawn_tutorial_enemy")

func stop_music(_enemy : Enemy) -> void:
	var tween = create_tween()
	tween.tween_property(music,"volume_db", -1000, 100)

func delete_projectiles(_enemy : Enemy) -> void:
	for projectile in projectile_container.get_children():
		projectile.despawn()


func victory_music() -> void:
	music.stop()
	print("VICTORY MUSIC")
	music.stream = RUNNING_RETRO
	var tween = create_tween()
	music.play()
	tween.tween_property(music,"volume_db", 1, 100)
	
	



func respawn_tutorial_enemy() -> void:
	var new_enemy : Enemy = TUTORIAL_ENEMY.instantiate()
	new_enemy.global_position = Vector2(0,225)
	$Entities.add_child(new_enemy)
	
