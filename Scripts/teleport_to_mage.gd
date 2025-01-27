extends Teleport

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.change_scene(GameManager.MAGE_LEVEL)
