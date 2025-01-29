class_name OrcBoss
extends Enemy

var weapon: PackedScene = load("res://Scenes/Weapons/orc_weapon.tscn")

func _ready() -> void:
	health_setup()
	self.add_child(weapon.instantiate())

func _process(delta: float) -> void:
	movement()
	move_and_slide()
