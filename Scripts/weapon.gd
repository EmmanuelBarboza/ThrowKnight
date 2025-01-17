#Weapon.gd
class_name Weapon
extends Node2D

#Esta clase es una plantilla para el resto de armas si es que implemento mas


@onready var marker: Marker2D = $Marker2D
#Timer para impedir que se spamee el arma
@onready var shooting_delay_timer: Timer = $ShootingDelayTimer

#Escena de clase projectile que representa el proyectil que dispara el arma
@export var projectile: PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var throw_sound: AudioStreamPlayer2D = $ThrowSound

@export var weapon_rotate_speed: float = 10

func _ready() -> void:
	animation_player.play("RESET")

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
	if Input.is_action_just_pressed("shoot") and not shooting_delay_timer.time_left:
		animation_player.play("shoot")

func play_sound() -> void:
	throw_sound.play()

func shoot() -> void:
		var new_proyectile: Projectile = get_weapon_projectile().instantiate()
		new_proyectile.global_position = get_shooting_marker().global_position
		new_proyectile.rotation = rotation
		get_tree().root.add_child(new_proyectile)
		shooting_delay_timer.start()
		animation_player.play("RESET")
