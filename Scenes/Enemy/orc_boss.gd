class_name OrcBoss
extends Enemy

var weapon: PackedScene = load("res://Scenes/Weapons/orc_weapon.tscn")

var weapon_reference : Weapon

func _ready() -> void:
	health_setup()
	weapon_reference = weapon.instantiate()
	
	self.add_child(weapon_reference)
	print(get_node("OrcWeapon"))
	

func disable_weapon() -> void:
	get_node("OrcWeapon").queue_free()

func _process(_delta: float) -> void:
	if enemy_enabled:
		movement()
		move_and_slide()
