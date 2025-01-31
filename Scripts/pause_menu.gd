extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("on_pause_pressed", pause)

func pause(state: bool) -> void:
	if state == true:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true

func _on_texture_button_pressed() -> void:
	pause(true)


func _on_texture_button_2_pressed() -> void:
	pause(true)
	GameManager.change_main_scene()


func _on_texture_button_3_pressed() -> void:
	get_tree().root.add_child(load("res://Scenes/UI/options_menu.tscn").instantiate())
