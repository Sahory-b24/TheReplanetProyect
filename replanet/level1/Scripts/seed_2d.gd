extends Area2D

signal seedCollected(seed_name)

func _on_body_entered(body):
	if (body.name == "Player"):
		print("Semilla Recogida")
		emit_signal("seedCollected", name)
		queue_free()
