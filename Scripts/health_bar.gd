extends Control

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var label: Label = $TextureProgressBar/MarginContainer/Label




var max : float

func setup(max_health: float) -> void:
	max = max_health
	texture_progress_bar.max_value = max_health
	update_health(max_health)
	label.text = "%s" % max_health

func update_health(health: float) -> void:
	texture_progress_bar.value = health
	update_label(health)

func update_label(health: float) -> void:
	label.text = "%s" % health
