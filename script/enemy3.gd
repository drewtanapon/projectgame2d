extends Node2D

@export var speed: float = 250
@export var flip_sprite := true
@export var turn_cooldown := 0.12

# ตรงกับโครงสร้างโหนดในภาพ
@onready var rc_left: RayCast2D = $"Killzone/RayCastLeft"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var dir := -1            # เดินซ้ายตลอด
var turn_lock := 0.0

func _ready() -> void:
	if rc_left:
		rc_left.enabled = true
	if sprite:
		if flip_sprite:
			# เดินซ้ายให้หันซ้าย (ไม่ต้อง flip)
			sprite.flip_h = false
		if sprite.has_method("play"):
			sprite.play()

func _physics_process(delta: float) -> void:
	# ถ้าเคยคิดจะใช้คูลดาวน์เปลี่ยนทิศก็ลดไว้ (ยังไม่ใช้จริง)
	if turn_lock > 0.0:
		turn_lock -= delta

	# เดินทางซ้ายตลอด
	position.x += dir * speed * delta
