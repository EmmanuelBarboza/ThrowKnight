class_name Projectile
extends Area2D

@onready var visible_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var sprite_2d: Sprite2D = $Sprite2D



@export_group("Movement") #MOVEMENT RELATED VARIABLES
#The velocity at which the projectile travels
@export var speed_mult: float = 800
#Determines if the projectile is a spinning projectile
@export var spins: bool = true
#The velocity at which the projectile will spin
@export var spin_speed: float = 200
#If the projectile can move
@export var can_move: bool = true

@export var slow_spawn: bool = false

@export_group("Offensive stats") #OFFENSIVE RELATED VARIABLES
#The base damage of the projectile
@export var base_damage: float = 100 
#The ammount of obstacles the projectile destroys before despawn or bounce
@export var penetration: int = 1
#If the projectile bounces off walls or obstacles
@export var is_bouncy: bool = false 
#The ammount of bounces the projectiles does before despawn
@export var ammount_bounces: int = 0

#This function controlls the movement of the projectile
func movement(delta: float) -> void:
	

	if slow_spawn:
		animation_player.play("spawn")
	else:
		move_projectile(delta)

func change_direction(new_direction: Vector2) -> void:
	# Cambia la dirección a un nuevo vector normalizado
	transform.x = new_direction.normalized()


func move_projectile(delta: float) -> void:
	if can_move == true: 
		if spins == true:
			spin_logic(delta)
		#Moves the projectile on a straight line
		global_position += transform.x * speed_mult * delta 
		

func update_rotation_to_player() -> void:
	rotation = (GameManager.player.position - position).angle()

#This function rotates the sprite of the weapon
func spin_logic(delta: float) -> void:
		#Rotates the sprite at the spin speed
		sprite_2d.rotation_degrees += spin_speed * delta
		#Prevents the rotation angle from exceeding 360 degrees
		sprite_2d.rotation_degrees = wrap(sprite_2d.rotation_degrees,0 , 360)

#This function makes the projectile bounce from a wall or obstacle
func bounce_wall() -> void:
	if ammount_bounces > 0:
		#To make the projectile bounce the speed is multiplied by negative
		speed_mult = speed_mult * -1
		ammount_bounces -= 1
	else:
		despawn()

func toggle_can_move(value: bool) -> void:
	can_move = value

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	despawn()

func despawn() -> void:
	animation_player.play("despawn")

func _on_body_entered(body: Node2D) -> void:
	#If the body is not an entity, it means is a wall/obstacle
	if body is not Entity:
		#If the body is an obstacle and the weapon still has penetration
		#it will destroy the obstacle and continue 
		if body.is_in_group("Obstacles") and penetration > 0:
			body.queue_free()
			penetration -= 1
		else:
			#If the body was not an obstacle or the projectile had no more penetration
			#It will check if the projectile is bouncy, if it is, it will bounce
			#off the wall, if it isnt it will despawn
			if is_bouncy == false:
				despawn()
			else:
				bounce_wall()
