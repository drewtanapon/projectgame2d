extends Area2D

@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	Engine.time_scale = 0.2
	if body.get_node("CollisionShape2D"):
		body.get_node("CollisionShape2D").queue_free()
		timer.start()
	_on_timer_timeout()
	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
