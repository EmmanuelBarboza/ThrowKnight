extends Projectile
#Projectile for the zombie boss it spawns acid trails on its path

#When the timer runs out it spawns an acid trail

const TRAIL = preload("res://Scenes/Weapons/trail.tscn")




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)



func effect() -> void:
	var trail_new = TRAIL.instantiate()
	trail_new.position = global_position
	trail_new.rotation = rotation
	GameManager.spawn_trail(trail_new)



func _on_timer_timeout() -> void:
	effect()
