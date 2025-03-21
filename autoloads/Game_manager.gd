#GameManager autoload
extends Node


const GAME_OVER = preload("res://Scenes/Level/game_over.tscn")
const LEVEL = preload("res://Scenes/Level/level.tscn")
const MAIN_MENU = preload("res://Scenes/UI/main_menu.tscn")
const MAGE_LEVEL = preload("res://Scenes/Level/mage_level.tscn")
const THANKS_FOR_PLAYING = preload("res://Scenes/UI/thanks_for_playing.tscn")
const ZOMBIE_LEVEL = preload("res://Scenes/Level/zombie_level.tscn")
const ORC_BOSS_LEVEL = preload("res://Scenes/Level/OrcBoss_Level.tscn")
const COMPLEX_TRANSITION = preload("res://Scenes/UI/complex_transition.tscn")


var player: Player 

var next_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("on_player_die",_on_player_die)
	SignalManager.connect("on_player_ready",_set_player)
	SignalManager.connect("on_boss_defeated",on_boss_defeated)
	#process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	

func _on_player_die() -> void:
	Engine.time_scale = 1.0
	call_deferred("change_scene", GAME_OVER)

func _set_player(playerParam: Player) -> void:
	player = playerParam
	

func on_boss_defeated(enemy: Enemy) -> void:
	if enemy is ZombieBoss:
		complex_transition.label_text = "TIP: \n The flying skulls take \n some time to attack\n kill them while you can!"
		#change_scene(MAGE_LEVEL)
		
	elif enemy is MageBoss:
		complex_transition.label_text = "TIP: \n Stay away from walls\n and dodge the red mace!"
		#change_scene(load("res://Scenes/Level/OrcBoss_Level.tscn"))
	elif  enemy is OrcBoss:
		complex_transition.label_text = "CONGRATS \n You defeated all bosses!"
		#change_scene(THANKS_FOR_PLAYING)



func change_scene(scene: PackedScene) -> void:
	next_scene = scene
	call_deferred("_change_scene", scene)

func _change_scene(_scene: PackedScene) -> void:
	
	var transition = COMPLEX_TRANSITION.instantiate()
	add_child(transition)

func change_main_scene() -> void:
	complex_transition.label_text = ""
	call_deferred("change_scene", MAIN_MENU)

func spawn_projectile(projectile: Projectile, start_pos: Vector2) -> void:
	if player != null:
		# Calcula la dirección hacia el jugador y la normaliza
		var direction_to_player = (player.position - start_pos).normalized()
		# Cambia la dirección del proyectil a la dirección calculada
		projectile.change_direction(direction_to_player)
		get_tree().root.get_node("Level").get_node("ProjectileContainer").add_child(projectile)

func _spawn_projectile(projectile: Projectile) -> void:
	call_deferred("_spawn_projectile_deffered", projectile)

func _spawn_projectile_deffered(projectile: Projectile) -> void:
	get_tree().root.get_node("Level").get_node("ProjectileContainer").add_child(projectile)

func spawn_trail(trail_new: trail) -> void:
	get_tree().root.get_node("Level").get_node("ProjectileContainer").add_child(trail_new)

func exit_game() -> void:
	get_tree().quit()
