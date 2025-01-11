extends CharacterBody2D

@export var health: float = 500:
	set(value):
		health = value
		if health <= 0:
			die()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func die() -> void:
	set_process(false)
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is Projectile:
		health -= area.base_damage
