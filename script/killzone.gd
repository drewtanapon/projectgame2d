extends Area2D

@export var slowmo_seconds: float = 1.0
@export var slowmo_scale: float = 0.2

var _triggered := false
var death_sound: AudioStreamPlayer2D

func _ready() -> void:
	# สร้าง AudioStreamPlayer2D ขึ้นมาใน runtime
	death_sound = AudioStreamPlayer2D.new()
	add_child(death_sound)

	# โหลดไฟล์เสียงเข้ามา
	death_sound.stream = load("res://sound/GameOver.mp3")

func _on_body_entered(body: Node2D) -> void:
	if _triggered:
		return
	_triggered = true

	# ▶️ เล่นเสียง GameOver
	death_sound.play()

	print("[KillZone] You died! slow-mo for ", slowmo_seconds, "s")

	Engine.time_scale = slowmo_scale

	var col := body.get_node_or_null("CollisionShape2D")
	if col:
		col.set_deferred("disabled", true)

	set_deferred("monitoring", false)

	var end_ms := Time.get_ticks_msec() + int(slowmo_seconds * 1000.0)
	while Time.get_ticks_msec() < end_ms:
		await get_tree().process_frame

	Engine.time_scale = 1.0
	get_tree().change_scene_to_file("res://scenes/gameOver.tscn")
