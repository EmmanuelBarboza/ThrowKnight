class_name Entity
extends CharacterBody2D

#This class represents an enemy, could be a player or an enemy

#Holds the animated sprite
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

#Group of variables related to movement
@export_group("Movement")
@export var move_speed = 200

@export_group("Health")
@export var max_health : float = 1000

#Health of the entity, it uses  a set to check if hp is less or equal to 0, if so, the entity dies
var health: float = 1000:
	set(value):
		health = value
		if health <= 0:
			die()
		update_ui(health)

@export_group("Sounds")
@export var hit_sound: AudioStreamPlayer2D 

func _ready() -> void:
	
	health = max_health
	print(self, "MAX_HP: ", max_health, "Normal: ", health)

#Visual effect when getting hit, stretches the entity sprite then turns it to normal
var squash_and_stretch := 1.0:
	set(value):
		squash_and_stretch = value
		var _negative = 1.0 + (1.0 - squash_and_stretch)
		animated_sprite.scale = Vector2(1, squash_and_stretch)

func take_damage(damage: float) -> void:
	#print("TAKE DAMAGE: ", self , " AMMOUNT: ", damage)
	
	shader_logic(self)
	if hit_sound != null:
		hit_sound.play()
		
		print(self)
		
	do_squash_and_stretch(1.4,0.08)
	health -= damage
	

func shader_logic(_entity: Entity) -> void:
	pass

func heal(heal_ammount: float) -> void:
	
	health = minf(health + heal_ammount, max_health)
	print(health)

func update_ui(_health: float) -> void:
	pass

func emit_die_signal() -> void:
	pass



#Function that sets the process to falses and queue frees the entity
func die() -> void:
	#En caso de que muera el enemigo se para el process y se libera el nodo
	emit_die_signal()
	set_process(false)
	queue_free()


func do_squash_and_stretch(value: float, duration: float = 0.1):
	var tween = create_tween()
	tween.tween_property(self, "squash_and_stretch", value, duration)
	tween.tween_property(self, "squash_and_stretch", 1.0, duration * 1.8)
