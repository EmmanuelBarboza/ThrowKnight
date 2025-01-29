extends Projectile

const MACE_SPIKE = preload("res://Scenes/Weapons/mace_spike.tscn")
@onready var markers: Node2D = $Markers




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)




func despawn() -> void:
	
	markers.rotation = global_rotation
	for marker in markers.get_children():
		var new_proyectile: Projectile = MACE_SPIKE.instantiate()
		new_proyectile.global_position = marker.global_position
		new_proyectile.rotation = marker.global_rotation 
		
		if is_boosted:
			new_proyectile.is_boosted = is_boosted
			new_proyectile.base_damage += 5
			new_proyectile.penetration = 10
			new_proyectile.is_bouncy = true
			new_proyectile.ammount_bounces = 2
			new_proyectile.spins = true
		
		GameManager._spawn_projectile(new_proyectile)
	
	if is_boosted:
		despawn_sound.play()
	
	
	animation_player.play("despawn")
