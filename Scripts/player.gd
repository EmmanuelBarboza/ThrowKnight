#Player.gd
class_name Player
extends Entity


@onready var label: Label = $Label
var current_weapon_index: int = 0

@export_group("Weapon")
@export var weapon: Weapon


@export var weapon_scenes: Array = [preload("res://Scenes/Weapons/sword.tscn"), preload("res://Scenes/Weapons/axe.tscn")]

#const SWORD: PackedScene = preload("res://Scenes/Weapons/sword.tscn")
#const AXE: PackedScene = preload("res://Scenes/Weapons/axe.tscn")
@onready var health_bar: Control = $CanvasLayer/UI/HealthBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.setup(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_logic(delta)
	#shooting_logic()
	change_weapon()
	
	move_and_slide()
	
	

func change_weapon() -> void:
	if Input.is_action_just_pressed("switch_weapon"):
		current_weapon_index = (current_weapon_index + 1) % weapon_scenes.size()
		set_weapon(current_weapon_index)


func set_weapon(index: int) -> void:
	if index >= 0 and index < weapon_scenes.size():
		if weapon:
			weapon.queue_free()  # Elimina el arma anterior
		weapon = weapon_scenes[index].instantiate()
		add_child(weapon)  # Agrega la nueva arma como hijo
		current_weapon_index = index

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
	SignalManager.on_player_die.emit()
	#En caso de que muera el enemigo se para el process y se libera el nodo
	set_process(false)
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	#if area is Hurtbox:
		#print("ouch player")
		#take_damage(100)
	
	if  area.is_in_group("enemy_projectile"):
		if area is Projectile or trail:
			take_damage(area.base_damage)
	

func update_ui(_health: float) -> void:
	health_bar.update_health(_health)
