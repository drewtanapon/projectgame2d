extends Node2D

@export var speed: float = 250         # ความเร็วในการเคลื่อนที่
@export var flip_sprite := true        # ให้กลับด้าน sprite อัตโนมัติ
@export var turn_cooldown := 0.12      # หน่วงเวลาเล็กน้อย (ยังเก็บไว้เผื่อใช้)

@onready var rc: RayCast2D = $RayCast2Dup       # 🔹 ใช้ RayCast2Dup ตามซีนจริง
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var dir := -1    # 🔹 เดินไปทางซ้ายตลอด (dir = -1 → ซ้าย, dir = 1 → ขวา)
var turn_lock := 0.0

func _ready() -> void:
	if sprite:
		if flip_sprite:
			sprite.flip_h = false
		if sprite.has_method("play"):
			sprite.play()

func _process(delta: float) -> void:
	if turn_lock > 0.0:
		turn_lock -= delta

	var hit := rc and rc.is_colliding()

	# เดินไปทางซ้ายตลอด
	position.x += dir * speed * delta
