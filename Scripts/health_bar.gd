extends Control

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

func setup(max_health: float) -> void:
	texture_progress_bar.max_value = max_health
	update_health(max_health)

func update_health(health: float) -> void:
	texture_progress_bar.value = health
