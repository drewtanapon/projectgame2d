extends Area2D

@onready var game_manager = $"../GameManager"

var is_open = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func open_door():
	is_open = true
	if has_node("AnimationPlayer"):
		var anim = $AnimationPlayer
		anim.play("canPass")

func _on_body_entered(body):
	if is_open:
		game_manager.level_complete()
