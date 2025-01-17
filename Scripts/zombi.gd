extends Enemy

const ZOMBIE_ACID: PackedScene = preload("res://Scenes/Weapons/AcidBall.tscn")
const ACID_TRAIL = preload("res://Scenes/Weapons/acid_trail.tscn")

func _process(_delta: float) -> void:
	movement()
	move_and_slide()

#Shoots an acid ball towards the player
func shoot_basic() -> void:
	if is_on_follow_radius() == true:
		var new_proyectile = ZOMBIE_ACID.instantiate()
		new_proyectile.position = global_position
		new_proyectile.rotation = get_player_angle()
		get_tree().root.add_child(new_proyectile)
	

#Shoots an acid ball that leaves behind an acid trail
func acid_floor() -> void:
	if is_on_follow_radius() == true:
		#To shoot where the player is moving
		var rotation_mod = 1
		if get_player_direction().x > 0:
			rotation_mod = -1
		var trail_new = ACID_TRAIL.instantiate()
		trail_new.position = global_position
		trail_new.rotation = get_player_angle() + rotation_mod
		get_tree().root.add_child(trail_new)
