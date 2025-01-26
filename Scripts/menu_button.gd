extends TextureButton

@export var scale_over: Vector2 = Vector2(1.2,1.2)

@onready var default_scale: Vector2 = Vector2(scale.x, scale.y)

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export var scene_to_go: PackedScene 

@export var go_to_menu: bool = false

@export var go_to_options: bool = false

func _on_pressed() -> void:
	
	if scene_to_go != null:
		GameManager.change_scene(scene_to_go)
	elif go_to_menu == true:
		GameManager.change_main_scene()
	elif go_to_options:
		pass
	else:
		GameManager.exit_game()
	




func _on_mouse_entered() -> void:
	scale = scale_over
	if audio_player.playing == false:
		audio_player.play()
	


func _on_mouse_exited() -> void:
	scale = default_scale
