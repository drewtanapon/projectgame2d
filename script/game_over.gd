extends CanvasLayer

@export_file("*.tscn") var level_scene: String = "res://scenes/level_01.tscn"

@onready var title_label: Label = $MessageLabel
@onready var hint_label: Label = $"HBoxContainer/MessageLabel1"

func _ready() -> void:
	# ตั้งข้อความ
	if title_label:
		title_label.text = "GAME OVER"
	else:
		push_error("MessageLabel not found under CanvasLayer")

	if hint_label:
		hint_label.text = "กด Enter หรือ Space เพื่อเริ่มใหม่"
	else:
		push_error("MessageLabel1 not found under HBoxContainer")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select"):
		if level_scene != "":
			get_tree().change_scene_to_file(level_scene)
