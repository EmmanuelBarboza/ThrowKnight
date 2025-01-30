class_name Dialog
extends Control

@export_file("*.json") var dialog_file
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var name_text: RichTextLabel = $NinePatchRect/Name
@onready var text: RichTextLabel = $NinePatchRect/Text

@warning_ignore("unused_signal")
signal dialogue_finished
var dialogue = []
var current_dialog_id = 0
var d_active: bool = false

func _ready() -> void:
	nine_patch_rect.visible = false

func start():
	if d_active:
		return
	d_active = true
	dialogue = load_dialogue()
	current_dialog_id = -1
	nine_patch_rect.visible = true
	next_script()

func load_dialogue():
	var file = FileAccess.open(dialog_file, FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("chat") and d_active:
		next_script()

func next_script():
	current_dialog_id += 1
	print(len(dialogue))
	if current_dialog_id == len(dialogue):
		end_dialogue()
	else:
		name_text.text = dialogue[current_dialog_id]["name"]
		text.text = dialogue[current_dialog_id]["Text"]

func end_dialogue() -> void:
	d_active = false
	nine_patch_rect.visible = false
	emit_signal("dialogue_finished")
	
