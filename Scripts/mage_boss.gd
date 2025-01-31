class_name MageBoss
extends Enemy


const FIRE_BALL = preload("res://Scenes/Weapons/FireBall.tscn")
const FLYING_SKULL = preload("res://Scenes/Enemy/flying_skull.tscn")

@onready var markers: Node2D = $Markers

@onready var skull_spawn_timer: Timer = $Timers/SkullSpawnTimer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemy_enabled:
		movement()
		move_and_slide()
		markers.rotation = lerp_angle(markers.rotation, markers.rotation + 0.1, 10 * delta)
	
	
	


func multi_shot() -> void:
	if enemy_enabled:
		for marker in markers.get_children():
			var new_projectile: Projectile = FIRE_BALL.instantiate()
			new_projectile.position = marker.global_position
			new_projectile.rotation = get_player_angle()
			new_projectile.following_marker = marker
			new_projectile.follow_marker = true
			GameManager._spawn_projectile(new_projectile)
			


func skull_spawn() -> void:
	if FlyingSkull.skull_count < 2 and enemy_enabled == true:
		var new_skull:Enemy = FLYING_SKULL.instantiate()
		new_skull.position = global_position
		new_skull.position.x += 10 + randf_range(1, 5)
		get_tree().root.get_node("Level").get_node("Entities").add_child(new_skull)
