extends CharacterBody2D

@onready var dialog: Dialog = $Dialog
var is_chatting: bool = false
var player_in_chat_zone = false



func _on_dialog_dialogue_finished() -> void:
	is_chatting = false


func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	
	if body is Player:
		print(body)
		player_in_chat_zone = true
		dialog.start()


func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_chat_zone = false
		dialog.end_dialogue()
