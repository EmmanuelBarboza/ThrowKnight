extends Enemy

const ZOMBIE_ACID: PackedScene = preload("res://Scenes/Weapons/zombie_acid.tscn")


func _process(delta: float) -> void:
	movement()
	move_and_slide()

func shoot_basic() -> void:
	print("shooting")
	var new_proyectile = ZOMBIE_ACID.instantiate()
	new_proyectile.position = global_position
	new_proyectile.rotation = get_player_angle()
	get_tree().root.add_child(new_proyectile)
