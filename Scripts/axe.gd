extends Weapon





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	weapon_movement(_delta)
	shooting_logic()
	calculate_angular_velocity(_delta)
