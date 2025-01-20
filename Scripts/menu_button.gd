extends TextureButton

@export var scale_over: Vector2 = Vector2(1.2,1.2)

@onready var default_scale: Vector2 = Vector2(scale.x, scale.y)

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export var scene_to_go: PackedScene 

@export var go_to_menu: bool = false

func _on_pressed() -> void:
	
	if go_to_menu:
		GameManager.change_main_scene()
		return
	
	if scene_to_go != null:
		GameManager.change_scene(scene_to_go)
	else:
		GameManager.exit_game()


func _on_mouse_entered() -> void:
	scale = scale_over
	if audio_player.playing == false:
		audio_player.play()
	


func _on_mouse_exited() -> void:
	scale = default_scale
