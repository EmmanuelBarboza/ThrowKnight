class_name Player
extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var label: Label = $Label


@export_group("Movement")
@export var move_speed = 200

@export_group("Weapon")
@export var weapon: Weapon




#const SWORD: PackedScene = preload("res://Scenes/Weapons/sword.tscn")
const AXE: PackedScene = preload("res://Scenes/Weapons/axe.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_logic(delta)
	#shooting_logic()
	
	
	move_and_slide()
	
	

#func shooting_logic() -> void:
	#if Input.is_action_just_released("shoot") and not shooting_timer.time_left:
		#var new_proyectile: Projectile = weapon.get_weapon_projectile().instantiate()
		#new_proyectile.global_position = weapon.get_shooting_marker().global_position
		#new_proyectile.rotation = weapon.rotation
		#get_tree().root.add_child(new_proyectile)
		#shooting_timer.start()

func  move_logic(_delta: float) -> void:
	
	var direction = Input.get_vector("left","right","up","down").normalized() * move_speed
	
	label.text = "%.2f , %.2f" % [direction.x, direction.y] 
	
	if direction != Vector2.ZERO:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
	
	if direction.x < 0:
		animated_sprite.flip_h = true
	elif direction.x > 0:
		animated_sprite.flip_h = false
	
	
	
	velocity = direction
	
