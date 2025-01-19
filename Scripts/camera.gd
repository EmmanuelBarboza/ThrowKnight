extends Camera2D

@export var speed_x: float = 200
@export var speed_y: float = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	follow_mouse() 

func follow_mouse() -> void:
	var mouse_pos = get_global_mouse_position()
	offset.x = speed_x * (mouse_pos.x - global_position.x) / get_viewport_rect().size.x
	offset.y = speed_y * (mouse_pos.y - global_position.y) / get_viewport_rect().size.y
