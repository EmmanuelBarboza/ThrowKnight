class_name MageBoss
extends Enemy


const ACID_BALL = preload("res://Scenes/Weapons/AcidBall.tscn")
@onready var markers: Node2D = $Markers


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement()
	move_and_slide()
	
	markers.rotation = lerp_angle(markers.rotation, markers.rotation + 0.1, 10 * delta)
	


func multi_shot() -> void:
	
	for marker in markers.get_children():
		var new_projectile: Projectile = ACID_BALL.instantiate()
		new_projectile.position = marker.global_position
		new_projectile.rotation = get_player_angle()
		new_projectile.following_marker = marker
		new_projectile.follow_marker = true
		GameManager._spawn_projectile(new_projectile)
	
	
