extends Projectile

var knock_back_strength: float = 100


func _process(delta: float) -> void:
	movement(delta)



func _on_body_entered_knockbac(body: Node2D) -> void:
	if body is Enemy:
		var direction = global_position.direction_to(body.global_position)
		var knockback_force = direction * knock_back_strength
		body.knockback = knockback_force
		body.knock_back_timer.start()
