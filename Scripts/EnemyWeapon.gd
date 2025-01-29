extends Weapon

var projectiles_untill_boost: int = 0

@export var boost_treshold: int = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	weapon_movement(delta)
	if projectiles_untill_boost == boost_treshold:
		boost_warning()

func boost_warning() -> void:
	sprite.material.set_shader_parameter("blink_intensity", 1)

func weapon_movement(delta: float) -> void:
	# Calcula el ángulo objetivo hacia el mouse
	var target_rotation = (GameManager.player.global_position - global_position).angle()
	
	# Interpola suavemente hacia el ángulo objetivo
	rotation = lerp_angle(rotation, target_rotation, weapon_rotate_speed * delta)
	
	# Normaliza el ángulo en grados
	var degrees = rad_to_deg(rotation)
	degrees = wrap(degrees, 0, 360)
	
	# Ajusta el escalado según el ángulo
	if degrees > 90 and degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

func shooting_logic() -> void:
	if disabled == false:
		animation_player.play("shoot")

func randomize_boost() -> void:
	boost_treshold = randi_range(boost_treshold, 7)

func shoot() -> void:
	
	var new_proyectile: Projectile = get_weapon_projectile().instantiate()
	new_proyectile.global_position = get_shooting_marker().global_position
	new_proyectile.rotation = rotation
	
	if projectiles_untill_boost == boost_treshold:
		new_proyectile.is_boosted = true
		new_proyectile.base_damage *= 5
		projectiles_untill_boost = 0
		sprite.material.set_shader_parameter("blink_intensity", 0)
		randomize_boost()
	
	GameManager._spawn_projectile(new_proyectile)
	shooting_delay_timer.start()
	animation_player.play("RESET")
	
	projectiles_untill_boost += 1
	
	if  projectiles_untill_boost == boost_treshold:
		boost_shoot_sound.play()
