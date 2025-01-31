extends CustomButton

@export var ui_parent : Control

func _on_pressed() -> void:
	ui_parent.queue_free()
