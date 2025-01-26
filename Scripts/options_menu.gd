extends Control


@onready var camera_type: ItemList = $MarginContainer/VBoxContainer/CameraType


func _on_camera_type_item_selected(index: int) -> void:
	if camera_type.get_item_text(index) == "Static":
		PlayerCamera.is_dynamic = false
		print("Camera set to static")
	else:
		PlayerCamera.is_dynamic = true
		print("Camera set to dynamic")
