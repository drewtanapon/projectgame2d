extends Node2D

@export var speed: float = 250         # ความเร็วในการเคลื่อนที่
@export var flip_sprite := true          # ให้กลับด้าน sprite อัตโนมัติ
@export var turn_cooldown := 0.12        # หน่วงเวลาเล็กน้อย (ยังเก็บไว้เผื่อใช้)

@onready var rc_left:  RayCast2D = $RayCastLeft
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var dir := -1    # 🔹 เดินไปทางซ้ายตลอด
var turn_lock := 0.0

func _ready() -> void:
	if sprite:
		if flip_sprite:
			# 🔹 ปรับตรงนี้  ถ้าเดินซ้าย ไม่ต้องกลับด้าน (flip_h = false)
			sprite.flip_h = false
		if sprite.has_method("play"):
			sprite.play()

func _process(delta: float) -> void:
	if turn_lock > 0.0:
		turn_lock -= delta

	var hit_l := rc_left and rc_left.is_colliding()

	# เดินไปทางซ้ายตลอด
	position.x += dir * speed * delta
