extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func switch_scene():
	get_tree().change_scene_to_packed(GameManager.next_scene)


func _on_animation_finished(anim_name: StringName) -> void:
	queue_free()
