extends Area2D

signal seedCollected(seed_name)

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		emit_signal("seedCollected", name)
		queue_free()
