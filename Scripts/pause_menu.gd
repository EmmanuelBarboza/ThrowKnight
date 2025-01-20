extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.connect("on_pause_pressed", pause)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
