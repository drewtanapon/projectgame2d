extends Node

@onready var scorelabel = $"../player/Camera2D/ScoreLabel"
var total_candy = 0
var collected_candy = 0

var levels = [
	"res://scenes/level_01.tscn",
	"res://scenes/level_02.tscn",
	"res://scenes/level_03.tscn",
	"res://scenes/level_04.tscn",
	"res://scenes/level_05.tscn",
	"res://scenes/level_06.tscn"
]

func _ready():
	var candy_node = get_tree().get_current_scene().get_node("candy")
	if candy_node:
		total_candy = candy_node.get_child_count()
	collected_candy = 0
	print("Candy ทั้งหมด: ", total_candy)

	# หา scorelabel ใหม่ทุกครั้งที่เปลี่ยนฉาก
	var label_path = "player/Camera2D/ScoreLabel"
	if get_tree().get_current_scene().has_node(label_path):
		scorelabel = get_tree().get_current_scene().get_node(label_path)

func collect_candy():
	collected_candy += 1
	if scorelabel:
		scorelabel.text = "Your collected %d / %d coins." % [collected_candy, total_candy]
	print("Your collected %d / %d coins." % [collected_candy, total_candy])

	if collected_candy >= total_candy:
		level_complete()

func level_complete():
	print("congratulations!! ")

	# หาว่าเรากำลังอยู่ด่านที่เท่าไรใน levels[]
	var current_scene = get_tree().current_scene.scene_file_path
	var current_index = levels.find(current_scene)

	if current_index == -1:
		print("⚠️ ไม่เจอฉากปัจจุบันใน list levels")
		return

	var next_index = current_index + 1
	if next_index < levels.size():
		var next_scene = levels[next_index]
		get_tree().change_scene_to_file(next_scene)
	else:
		print("ไม่มีด่านถัดไปแล้ว 🎉")
