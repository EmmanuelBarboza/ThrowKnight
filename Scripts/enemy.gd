class_name Enemy
extends Entity

@onready var knock_back_timer: Timer = $KnockBackTimer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

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

@export var enemy_enabled : bool = true


func _ready() -> void:
	health_setup()
	

func health_setup() -> void:
	health = max_health
	health_bar.init_health(max_health)


func _process(_delta: float) -> void:
	movement()
	move_and_slide()
	


#Function that sets the process to falses and queue frees the entity
func die() -> void:
	animation_player.play("die")

#label.text = "%.2f , %.2f" % [target_direction.x , target_direction.y]

func disable_weapon() -> void:
	pass

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
		
	

func begin_shake() -> void:
	var tween = create_tween()
	var shake_intensity = 2.5  # Intensidad de la vibración
	var shake_duration = 0.2   # Duración total de la vibración
	
	for i in range(50):  # Número de vibraciones
		var random_offset = Vector2(randf_range(-shake_intensity, shake_intensity), randf_range(-shake_intensity, shake_intensity))
		tween.tween_property(self, "position", position + random_offset, shake_duration / 10)
		tween.tween_property(self, "position", position, shake_duration / 10)
		

func is_on_follow_radius() -> bool:
	if get_player_distance() < follow_radius:
		return true
	return false

func begin_fade() -> void:
	var tween = create_tween()
	tween.tween_method(shader_blink, 1.0,0.0, 1)


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
