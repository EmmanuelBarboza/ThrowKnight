extends Projectile



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)



func _on_timer_timeout() -> void:
	toggle_can_damage(true)
