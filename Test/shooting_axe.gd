extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animated_sprite_2d.rotation_degrees += 1600 * delta
	animated_sprite_2d.rotation_degrees = wrap(animated_sprite_2d.rotation_degrees,0 , 360)
	global_position += transform.x * 500 * delta
