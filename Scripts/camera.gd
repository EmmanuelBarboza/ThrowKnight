class_name PlayerCamera
extends Camera2D

@export var speed_x: float = 200
@export var speed_y: float = 200

var cameraShakeNoise: FastNoiseLite

static var is_dynamic: bool = true 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cameraShakeNoise = FastNoiseLite.new()
	
	if is_dynamic == false:
		position_smoothing_enabled = false

func start_camera_shake(intensity: float) -> void:
	
	if is_dynamic == false:
		offset.x = 0
		offset.y = 0
	
	var cameraOffset = cameraShakeNoise.get_noise_1d(Time.get_ticks_msec()) * intensity
	offset.x += cameraOffset
	offset.y += cameraOffset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_dynamic:
		follow_mouse() 


func follow_mouse() -> void:
	var mouse_pos = get_global_mouse_position()
	offset.x = speed_x * (mouse_pos.x - global_position.x) / get_viewport_rect().size.x
	offset.y = speed_y * (mouse_pos.y - global_position.y) / get_viewport_rect().size.y
