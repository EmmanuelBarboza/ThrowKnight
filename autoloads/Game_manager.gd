extends Node

const GAME_OVER = preload("res://Scenes/Level/game_over.tscn")
const LEVEL = preload("res://Scenes/Level/level.tscn")
const MAIN_MENU = preload("res://Scenes/UI/main_menu.tscn")
const MAGE_LEVEL = preload("res://Scenes/Level/mage_level.tscn")

var player: Player 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("on_player_die",_on_player_die)
	SignalManager.connect("on_player_ready",_set_player)
	SignalManager.connect("on_boss_defeated",on_boss_defeated)
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	

func _on_player_die() -> void:
	Engine.time_scale = 1.0
	call_deferred("change_scene", GAME_OVER)

func _set_player(playerParam: Player) -> void:
	print("Parameter: ",playerParam)
	player = playerParam
	print("TEST: ",player.position)

func on_boss_defeated(enemy: Enemy) -> void:
	
	if enemy is ZombieBoss:
		change_scene(MAGE_LEVEL)
	elif enemy is MageBoss:
		change_main_scene()
	

func change_scene(scene: PackedScene) -> void:
	call_deferred("_change_scene", scene)

func _change_scene(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)

func change_main_scene() -> void:
	call_deferred("change_scene", MAIN_MENU)

func spawn_projectile(projectile: Projectile, start_pos: Vector2) -> void:
	# Calcula la dirección hacia el jugador y la normaliza
	var direction_to_player = (player.position - start_pos).normalized()
	# Cambia la dirección del proyectil a la dirección calculada
	projectile.change_direction(direction_to_player)
	
	get_tree().root.get_node("Level").get_node("ProjectileContainer").add_child(projectile)

func _spawn_projectile(projectile: Projectile) -> void:
	get_tree().root.get_node("Level").get_node("ProjectileContainer").add_child(projectile)

func spawn_trail(trail_new: trail) -> void:
	get_tree().root.get_node("Level").get_node("ProjectileContainer").add_child(trail_new)

func exit_game() -> void:
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player != null:
		print(player.position)
