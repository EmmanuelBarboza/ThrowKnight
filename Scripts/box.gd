extends StaticBody2D





func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Projectile:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		queue_free()
