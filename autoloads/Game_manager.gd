extends Node

const GAME_OVER = preload("res://Scenes/Level/game_over.tscn")
const LEVEL = preload("res://Scenes/Level/level.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("on_player_die",_on_player_die)

func _on_player_die() -> void:
	get_tree().change_scene_to_packed(GAME_OVER)

func change_scene(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)

func change_main_scene() -> void:
	get_tree().change_scene_to_packed(LEVEL)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
