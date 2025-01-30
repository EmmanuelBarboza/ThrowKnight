extends Enemy

const ZOMBIE_ACID: PackedScene = preload("res://Scenes/Weapons/AcidBall.tscn")

func _process(_delta: float) -> void:
	movement()
	move_and_slide()
	

func die() -> void:
	#En caso de que muera el enemigo se para el process y se libera el nodo
	emit_die_signal()
	set_process(false)
	queue_free()

func emit_die_signal() -> void:
	SignalManager.on_tutorial_died.emit()

func shoot_basic() -> void:
	if is_on_follow_radius():
		var new_proyectile: Projectile = ZOMBIE_ACID.instantiate()
		new_proyectile.position = global_position
		new_proyectile.rotation = get_player_angle()
		new_proyectile.base_damage = 10
		new_proyectile.speed_mult = 100
		GameManager.spawn_projectile(new_proyectile, position)
