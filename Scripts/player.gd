class_name Player
extends Entity


@onready var label: Label = $Label


@export_group("Weapon")
@export var weapon: Weapon




#const SWORD: PackedScene = preload("res://Scenes/Weapons/sword.tscn")
#const AXE: PackedScene = preload("res://Scenes/Weapons/axe.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_logic(delta)
	#shooting_logic()
	
	
	move_and_slide()
	
	

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
	


func die() -> void:
	#En caso de que muera el enemigo se para el process y se libera el nodo
	set_process(false)
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		print("ouch player")
		take_damage(100)
