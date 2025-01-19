extends Node

const GAME_OVER = preload("res://Scenes/Level/game_over.tscn")
const LEVEL = preload("res://Scenes/Level/level.tscn")
const MAIN_MENU = preload("res://Scenes/UI/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("on_player_die",_on_player_die)

func _on_player_die() -> void:
	Engine.time_scale = 1.0
	call_deferred("change_scene", GAME_OVER)

func change_scene(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)

func change_main_scene() -> void:
	call_deferred("change_scene", MAIN_MENU)

func spawn_projectile(projectile) -> void:
	get_tree().root.get_node("Level").get_node("ProjectileContainer").add_child(projectile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
