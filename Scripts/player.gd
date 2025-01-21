#Player.gd
class_name Player
extends Entity

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var time_stop_duration_timer: Timer = $Timers/TimeStopDurationTimer
@onready var time_stop_cooldown_timer: Timer = $Timers/TimeStopCooldownTimer


@onready var label: Label = $Label
var current_weapon_index: int = 0

@export_group("Weapon")
@export var weapon: Weapon


@export var weapon_scenes: Array = [preload("res://Scenes/Weapons/sword.tscn"), preload("res://Scenes/Weapons/axe.tscn")]

#const SWORD: PackedScene = preload("res://Scenes/Weapons/sword.tscn")
#const AXE: PackedScene = preload("res://Scenes/Weapons/axe.tscn")
@onready var health_bar: Control = $CanvasLayer/UI/HealthBar

var pause_state : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	health_bar.setup(max_health)
	animation_player.play("idle")
	set_weapon(0)
	SignalManager.on_player_ready.emit(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_logic(delta)
	change_weapon()
	pause_logic()
	ability_logic()
	move_and_slide()
	
	if Input.is_key_pressed(KEY_ENTER):
		die()
	
	

func pause_logic() -> void:
	if Input.is_action_just_pressed("pause"):
		SignalManager.on_pause_pressed.emit(false)

func change_weapon() -> void:
	if Input.is_action_just_pressed("switch_weapon"):
		current_weapon_index = (current_weapon_index + 1) % weapon_scenes.size()
		set_weapon(current_weapon_index)


func set_weapon(index: int) -> void:
	var weapon_pos = Vector2.ZERO
	if index >= 0 and index < weapon_scenes.size():
		if weapon:
			weapon_pos = weapon.position
			weapon.queue_free()  # Elimina el arma anterior
		weapon = weapon_scenes[index].instantiate()
		weapon.position = weapon_pos
		add_child(weapon)  # Agrega la nueva arma como hijo
		current_weapon_index = index

func ability_logic() -> void:
	if (Input.is_action_just_pressed("ability") 
	and not time_stop_duration_timer.time_left
	and not time_stop_cooldown_timer.time_left):
		time_stop_duration_timer.start()
		time_stop_cooldown_timer.start()
		Engine.time_scale = 0.2

func  move_logic(_delta: float) -> void:
	
	var direction: Vector2 = Input.get_vector("left","right","up","down").normalized() * move_speed
	
	
	
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
	


func die() -> void:
	Engine.time_scale = 0.5
	set_process(false)
	weapon.hide()
	weapon.set_process(false)
	animation_player.play("die")

func  emit_die_signal() -> void:
	SignalManager.on_player_die.emit()
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	#if area is Hurtbox:
		#print("ouch player")
		#take_damage(100)
	
	if  area.is_in_group("enemy_projectile"):
		if area is Projectile or trail:
			take_damage(area.base_damage)
			area.despawn()
	

func update_ui(_health: float) -> void:
	health_bar.update_health(_health)


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
