extends Area2D


@export var heal_ammount: float = 250
@onready var effect_sound: AudioStreamPlayer2D = $EffectSound
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		effect_sound.play()
		body.heal(heal_ammount)
		animation_player.play("despawn")
	
