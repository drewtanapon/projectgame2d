extends CanvasLayer

@export_file("*.tscn") var level_scene: String = "res://scenes/level_01.tscn"

# <<< ตั้งจาก Inspector ให้ชัดเจน >>>
@export var title_label_path: NodePath
@export var hint_label_path: NodePath

var title_label: Label
var hint_label: Label
var _can_accept_input := false

func _ready() -> void:
	# รอ 1 เฟรมให้ซีนประกอบครบก่อนค่อย resolve โหนด
	await get_tree().process_frame

	# resolve โหนดจาก NodePath ที่ตั้งใน Inspector
	if title_label_path != NodePath():
		title_label = get_node_or_null(title_label_path) as Label
	if hint_label_path != NodePath():
		hint_label = get_node_or_null(hint_label_path) as Label

	# ถ้ายังไม่ได้ตั้ง ให้ลองหาแบบ fallback ตามชื่อที่คาดไว้
	if title_label == null:
		title_label = get_node_or_null("MessageLabel") as Label
	if hint_label == null:
		hint_label = get_node_or_null("MessageLabel1") as Label
	if hint_label == null:
		hint_label = get_node_or_null("HBoxContainer/MessageLabel1") as Label

	# ตั้งข้อความ (และแจ้ง error ถ้าไม่พบ)
	if title_label:
		title_label.text = "GAME OVER"
	else:
		push_error("[GameOver] ไม่พบโหนดหัวเรื่อง (ตั้ง title_label_path ใน Inspector)")

	if hint_label:
		hint_label.text = "กด Enter หรือ Space เพื่อเริ่มใหม่"
	else:
		push_error("[GameOver] ไม่พบโหนดคำแนะนำ (ตั้ง hint_label_path ใน Inspector)")

	# กันกดค้างแล้วเด้งเริ่มใหม่ทันที
	await get_tree().create_timer(0.25, false, true).timeout
	_can_accept_input = true

func _unhandled_input(event: InputEvent) -> void:
	if not _can_accept_input:
		return
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select"):
		get_tree().change_scene_to_file(level_scene)
