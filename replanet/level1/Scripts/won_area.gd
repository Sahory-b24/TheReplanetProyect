extends Area2D

signal level_won

func _on_body_entered(body: Node2D):
	if body.name == "Player":
		emit_signal("level_won")
