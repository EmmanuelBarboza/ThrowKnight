class_name  FlyingSkull
extends Enemy


@onready var charge_timer: Timer = $Timers/ChargeTimer
const FIRE_BALL_SMALL = preload("res://Scenes/Weapons/fire_ball_small.tscn")
var rotation_speed = 2.0 # Velocidad de rotación (radianes por segundo)
var distance_from_player = 75.0 # Distancia fija entre el enemigo y el jugador
var current_angle = 0.0 # Ángulo actual de la rotación

static var skull_count = 0

func _ready() -> void:
	health_setup()
	skull_count += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	target_direction= get_player_direction()
	flip_sprite()
	movement_arround(delta)
	

func attack() -> void:
	if not charge_timer.time_left:
		var new_proyectile: Projectile = FIRE_BALL_SMALL.instantiate()
		new_proyectile.position = global_position
		new_proyectile.rotation = get_player_angle()
		new_proyectile.slow_spawn = false
		new_proyectile.speed_mult = 500
		GameManager._spawn_projectile(new_proyectile)

func movement_arround(delta: float) -> void:
	if player:
		current_angle += rotation_speed * delta
		var x = player.global_position.x + cos(current_angle) * distance_from_player
		var y = player.global_position.y + sin(current_angle) * distance_from_player
		
		var tween = create_tween()
		tween.tween_property(self, "global_position", Vector2(x,y),0.5)



func _on_tree_exiting() -> void:
	skull_count -= 1
