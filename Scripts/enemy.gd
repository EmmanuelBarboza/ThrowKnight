class_name Enemy
extends Entity

@onready var knock_back_timer: Timer = $KnockBackTimer


@onready var health_bar: ProgressBar = $HealthBar

var knockback : Vector2 = Vector2(0,0)

@onready var player: Player = get_tree().get_first_node_in_group("Player")

@onready var label: Label = $Label

var tolerance: float = 0.0

var target_direction: Vector2

@export var follow_radius: float = 100.0

@export var attack_radius: float = 25.0

@export_group("Phase tresholds")
@export var phase_1_treshold: float
@export var phase_2_treshold: float
@export var phase_3_treshold: float

func _ready() -> void:
	health_setup()
	

func health_setup() -> void:
	health = max_health
	health_bar.init_health(max_health)
	print("done")

func _process(_delta: float) -> void:
	
	movement()
	move_and_slide()
	

#label.text = "%.2f , %.2f" % [target_direction.x , target_direction.y]

func movement() -> void:
	
	target_direction= get_player_direction()
	
	if  velocity != Vector2.ZERO:
		animated_sprite.play("run")
	
	follow_player()
	flip_sprite()
	

func get_player_angle() -> float:
	if player != null:
		return (player.position - position).angle()
	return 0.0

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
	if is_on_follow_radius():
		velocity = target_direction  * move_speed + knockback
	
	if get_player_distance() < attack_radius:
		velocity = Vector2.ZERO
		
	



func is_on_follow_radius() -> bool:
	if get_player_distance() < follow_radius:
		return true
	return false

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
	if area is Projectile and area.is_in_group("player_projectile"):
		area.queue_free()
		take_damage(area.base_damage)

func update_ui(_health: float) -> void:
	health_bar.update_health(_health)

func shader_logic(_entity: Entity) -> void:
	var tween = create_tween()
	tween.tween_method(shader_blink, 1.0,0.0, 0.5)


func shader_blink (newValue : float):
	animated_sprite.material.set_shader_parameter("blink_intensity", newValue)

func emit_die_signal() -> void:
	SignalManager.on_boss_defeated.emit(self)


func _on_knock_back_timer_timeout() -> void:
	knockback = Vector2.ZERO
	print("RESET KNOCKBACK")
