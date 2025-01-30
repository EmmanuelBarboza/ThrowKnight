class_name ZombieBoss
extends Enemy

const ZOMBIE_ACID: PackedScene = preload("res://Scenes/Weapons/AcidBall.tscn")

const ACID_TRAIL: PackedScene = preload("res://Scenes/Weapons/acid_trail.tscn")

@onready var basic_attack_timer: Timer = $Timers/BasicAttackTimer
@onready var trail_attack_timer: Timer = $Timers/TrailAttackTimer
@onready var bleed_particle: GPUParticles2D = $BleedParticle



const ZOMBI_ENRAGED = preload("res://Scenes/Enemy/zombi_enraged.tres")

var bouncy: bool = false


func _process(_delta: float) -> void:
	if enemy_enabled:
		movement()
		move_and_slide()
		
		if health < phase_1_treshold:
			animated_sprite.sprite_frames = ZOMBI_ENRAGED
		if health < phase_2_treshold:
			bleed_particle.emitting = true


#Shoots an acid ball towards the player
func shoot_basic() -> void:
	if is_on_follow_radius() == true and enemy_enabled == true:
		var new_proyectile: Projectile = ZOMBIE_ACID.instantiate()
		phase_attributes(new_proyectile)
		new_proyectile.position = global_position
		new_proyectile.rotation = get_player_angle()
		GameManager.spawn_projectile(new_proyectile, position)
		slow_down()

func slow_down() -> void:
	var tween = create_tween()
	tween.tween_property(self, "move_speed", 18, 0.5)
	tween.tween_property(self, "move_speed", 30, 0.01)

#Shoots an acid ball that leaves behind an acid trail
func acid_floor() -> void:
	if is_on_follow_radius() == true and enemy_enabled == true:
		#To shoot where the player is moving
		var rotation_mod = 1
		if get_player_direction().x > 0:
			rotation_mod = -1
		var trail_new: Projectile = ACID_TRAIL.instantiate()
		phase_attributes(trail_new)
		trail_new.position = global_position
		trail_new.rotation = get_player_angle() + rotation_mod
		GameManager._spawn_projectile(trail_new)

func phase_attributes(projectile: Projectile) -> void:
	if health <= phase_1_treshold:
		projectile.is_bouncy = true
	if health <= phase_2_treshold:
		projectile.speed_mult += 50
		
	if health <= phase_3_treshold:
		basic_attack_timer.wait_time = 0.8
		trail_attack_timer.wait_time = 0.7
	
