extends Area2D

signal mushroomTouched(mushroom_name)


func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("mushroomTouched", name)
		
