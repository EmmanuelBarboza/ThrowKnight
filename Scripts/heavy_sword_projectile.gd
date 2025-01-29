extends Projectile

var blockeable_projectiles : int = 7

var projectiles_blocked : int = 0

@onready var block_particle: GPUParticles2D = $BlockParticle
@onready var block_sound: AudioStreamPlayer2D = $BlockSound


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement(delta)





func _on_area_entered(area: Area2D) -> void:
	print("Area entered")
	if area is Projectile and projectiles_blocked <= blockeable_projectiles:
		block_particle.emitting = true
		block_sound.play()
		area.despawn()
		projectiles_blocked += 1
