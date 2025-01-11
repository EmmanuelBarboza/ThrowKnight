class_name Weapon
extends Node2D

#Esta clase es una plantilla para el resto de armas si es que implemento mas
@onready var marker: Marker2D = $Marker2D
#Timer para impedir que se spamee el arma
@onready var shooting_delay_timer: Timer = $ShootingDelayTimer

#Escena de clase projectile que representa el proyectil que dispara el arma
@export var projectile: PackedScene


#Esta funcion devuelve el marcador, usado en el arma para la posicion inical del 
#Proyectil y la rotacion 
func get_shooting_marker() -> Marker2D:
	return marker

#Devuelve el tipo de proyu
func get_weapon_projectile() -> PackedScene:
	return projectile

func weapon_movement() -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

func shooting_logic() -> void:
	if Input.is_action_just_released("shoot") and not shooting_delay_timer.time_left:
		var new_proyectile: Projectile = get_weapon_projectile().instantiate()
		new_proyectile.global_position = get_shooting_marker().global_position
		new_proyectile.rotation = rotation
		get_tree().root.add_child(new_proyectile)
		shooting_delay_timer.start()
