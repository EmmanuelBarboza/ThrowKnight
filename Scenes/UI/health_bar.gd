extends ProgressBar

@onready var timer: Timer = $Timer
@onready var damage_bar: ProgressBar = $DamageBar

var health = 0 : set = update_health

func init_health(healthParam: float) -> void:
	max_value = healthParam
	health = healthParam
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func update_health(healthParam: float) -> void:
	var prev_health = health
	health = min(max_value, healthParam)
	value = health
	
	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health


func _on_timer_timeout() -> void:
	damage_bar.value = health
