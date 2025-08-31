extends Node

@onready var scorelabel = $"../player/Camera2D/ScoreLabel"

var total_candy = 0
var collected_candy = 0
var station = 1

func _ready():
	# นับจำนวน candy ทั้งหมดใน level
	total_candy = get_tree().get_current_scene().get_node("candy").get_child_count()
	collected_candy = 0
	print("Candy ทั้งหมด: ", total_candy)

func collect_candy():
	collected_candy += 1
	scorelabel.text = "Your collected %d / %d coins." % [collected_candy, total_candy]
	print("Your collected %d / %d coins." % [collected_candy, total_candy])

	if collected_candy >= total_candy:
		level_complete()

func level_complete():
	print("congratulations!! ")
	station+=1
	# ตัวอย่าง: เปลี่ยนฉาก
	get_tree().change_scene_to_file("res://scenes/level_0%d.tscn"%[station])
