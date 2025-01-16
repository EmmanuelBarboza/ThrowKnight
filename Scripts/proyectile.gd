class_name Projectile
extends Area2D

@onready var visible_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var spins: bool = true

@export_group("Velocities")
#Velocidad con la que viaja el proyectil
@export var speed_mult: float = 800
#Velocidad con la que gira el proyectil
@export var spin_speed: float = 200

@export var base_speed: float = 100

@export_group("Offensive stats")
@export var base_damage: float = 100 

func movement(delta: float) -> void:
	if spins:
		#Rotacion del sprite
		sprite_2d.rotation_degrees += spin_speed * delta
		#Evita que el angulo de rotacion supere los 360 grados
		sprite_2d.rotation_degrees = wrap(sprite_2d.rotation_degrees,0 , 360)

	#Hace que se mueva el proyectil en linea recta
	global_position += transform.x * speed_mult * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	set_process(false)
	queue_free()
