extends Weapon



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	weapon_movement(delta)
	shooting_logic()
