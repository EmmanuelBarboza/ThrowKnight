#Weapon.gd
class_name Weapon
extends Node2D

#Esta clase es una plantilla para el resto de armas si es que implemento mas
@onready var boost_shoot_sound: AudioStreamPlayer2D = $BoostShootSound


@onready var marker: Marker2D = $Marker2D
#Timer para impedir que se spamee el arma
@onready var shooting_delay_timer: Timer = $ShootingDelayTimer

#Escena de clase projectile que representa el proyectil que dispara el arma
@export var projectile: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var throw_sound: AudioStreamPlayer2D = $ThrowSound
@onready var sprite: Sprite2D = $Sprite2D


@export var weapon_rotate_speed: float = 10

@export var disabled: bool = false


var previous_rotation: float = 0.0
var angular_velocity: float = 0.0
@export var damage_multiplier: float = 2.0
@export var rotation_threshold: float = 30.0  # Velocidad mínima para aumentar daño

var next_shoot_boosted : bool = false

func _ready() -> void:
	animation_player.play("RESET")

func  _process(delta: float) -> void:
	
	calculate_angular_velocity(delta)

func toggle_next_shot_boosted(value: bool) -> void:
	next_shoot_boosted = value

func calculate_angular_velocity(delta: float) -> void:
	if next_shoot_boosted == true:
		return
	
	angular_velocity = abs(rotation - previous_rotation) / delta
	previous_rotation = rotation
	
	
	
	if angular_velocity > rotation_threshold:
		print("Boosted ", angular_velocity)
		next_shoot_boosted = true
		boost_shoot_sound.play()
		sprite.material.set_shader_parameter("blink_intensity", 1)



#Esta funcion devuelve el marcador, usado en el arma para la posicion inical del 
#Proyectil y la rotacion 
func get_shooting_marker() -> Marker2D:
	return marker

#Devuelve el tipo de proyu
func get_weapon_projectile() -> PackedScene:
	return projectile

#func weapon_movement() -> void:
	#look_at(get_global_mouse_position())
	#
	#rotation_degrees = wrap(rotation_degrees, 0, 360)
	#
	#if rotation_degrees > 90 and rotation_degrees < 270:
		#scale.y = -1
	#else:
		#scale.y = 1

func weapon_movement(delta: float) -> void:
	# Calcula el ángulo objetivo hacia el mouse
	var target_rotation = (get_global_mouse_position() - global_position).angle()
	
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
	if (Input.is_action_just_pressed("shoot") 
	and not shooting_delay_timer.time_left
	and disabled == false):
		animation_player.play("shoot")

func play_sound() -> void:
	throw_sound.play()

func shoot() -> void:
		var new_proyectile: Projectile = get_weapon_projectile().instantiate()
		new_proyectile.global_position = get_shooting_marker().global_position
		new_proyectile.rotation = rotation
		
		if new_proyectile.is_in_group("player_projectile") and next_shoot_boosted:
			new_proyectile.base_damage *=  damage_multiplier
			new_proyectile.is_boosted = true
			print("Boosted shot")
			sprite.material.set_shader_parameter("blink_intensity", 0)
		
		GameManager._spawn_projectile(new_proyectile)
		shooting_delay_timer.start()
		animation_player.play("RESET")
