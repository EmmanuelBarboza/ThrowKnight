class_name complex_transition
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tip_label: Label = $MarginContainer/TipLabel


static var label_text : String = "TIP: \n Dont stop moving!"


func _ready() -> void:
	change_label_text()

func switch_scene():
	get_tree().change_scene_to_packed(GameManager.next_scene)


func _on_animation_finished(_anim_name: StringName) -> void:
	queue_free()

func change_label_text() -> void:
	tip_label.text = label_text

func hide_label() -> void:
	tip_label.hide()
