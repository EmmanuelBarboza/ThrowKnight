extends CharacterBody2D

@export var _move_speed = 300
@onready var label: Label = $Label
const SHOOTING_AXE = preload("res://Test/shooting_axe.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	move_logic(delta)
	move_and_slide()
	spawn_proyectile()
	
	label.text = str($Weapon/Marker2D.position)

func spawn_proyectile() -> void:
	if Input.is_action_just_pressed("shoot"):
		var new_proyectile = SHOOTING_AXE.instantiate()
		new_proyectile.global_position = $Weapon/Marker2D.global_position
		new_proyectile.rotation = $Weapon.rotation
		get_parent().add_child(new_proyectile)


func  move_logic(delta: float) -> void:
	
	var direction_h = Input.get_axis("left","right")
	
	var direction_v = Input.get_axis("up","down")
	
	var vec_velocity: Vector2 = Vector2(direction_h, direction_v).normalized() * _move_speed 
	
	#label.text = "%f , %f" % [vec_velocity.x, vec_velocity.y] 
	
	velocity = vec_velocity
	
