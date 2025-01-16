class_name Enemy
extends Entity

@onready var player: Player = get_tree().get_first_node_in_group("Player")

@onready var label: Label = $Label

var tolerance: float = 0.6

var target_direction: Vector2

@export var follow_radius: float = 100.0

@export var attack_radius: float = 25.0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	movement()
	move_and_slide()

#label.text = "%.2f , %.2f" % [target_direction.x , target_direction.y]

func movement() -> void:
	
	target_direction= get_player_direction()
	
	follow_player()
	flip_sprite()
	


func flip_sprite() -> void:
	#Giramos el sprite dependiendo de a donde se mueva
	if  abs(target_direction.x) > tolerance:
		if target_direction.x < 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false

func follow_player() -> void:
	velocity = Vector2.ZERO
	
	
	#Hacemos que la velocidad vaya hacia el jugador multiplicado con la velocidad
	if get_player_distance() < follow_radius:
		velocity = target_direction  * move_speed
	
	if get_player_distance() < attack_radius:
		velocity = Vector2.ZERO

func get_player_direction() -> Vector2:
	#Obtenemos la direccion en la que se encuentra el jugador
	if player != null:
		return (player.position - position).normalized()
	return Vector2.ZERO

func get_player_distance() -> float:
	#Returns the distance to the player
	if player != null:
		return position.distance_to(player.position)
	return 0.0

func _on_hitbox_area_entered(area: Area2D) -> void:
	#Para cuando un proyectil toque la hitbox del enemigo
	if area is Projectile:
		area.queue_free()
		take_damage(area.base_damage)
