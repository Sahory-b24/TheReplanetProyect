extends Area2D

signal mushroomTouched(mushroom_name)


func _on_body_entered(body):
	if body.name == "Player":
		body.show_auch()
		emit_signal("mushroomTouched", name)
		
