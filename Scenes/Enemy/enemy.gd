class_name Enemy
extends CharacterBody2D

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var label: Label = $Label
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var tolerance: float = 0.6

@export var health: float = 500:
	set(value):
		health = value
		if health <= 0:
			die()

func _ready() -> void:
	pass



func _process(delta: float) -> void:
	movement()
	
	move_and_slide()


func movement() -> void:
	#Obtenemos la direccion en la que se encuentra el jugador
	var target_direction: Vector2 = (player.position - position).normalized()
	#Hacemos que la velocidad vaya hacia el jugador multiplicado con la velocidad
	velocity = target_direction  * 100
	label.text = "%.2f , %.2f" % [target_direction.x , target_direction.y]
	
	
	
	#Giramos el sprite dependiendo de a donde se mueva
	if  abs(target_direction.x) > tolerance:
		if target_direction.x < 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false



func die() -> void:
	#En caso de que muera el enemigo se para el process y se libera el nodo
	set_process(false)
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	#Para cuando un proyectil toque la hitbox del enemigo
	if area is Projectile:
		area.queue_free()
		health -= area.base_damage
