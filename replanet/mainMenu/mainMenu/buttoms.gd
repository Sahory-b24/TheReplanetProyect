extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_instructions_button_pressed() -> void:
	print("Instructions sirve")
	get_tree().change_scene_to_file("res://mainMenu/instructions.tscn")
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	print("credits sirve")
	get_tree().change_scene_to_file("res://mainMenu/credits.tscn")
	pass # Replace with function body.


func _on_start_button_4_pressed() -> void:
	print("Start sirve")
	get_tree().change_scene_to_file("res://mapa/assests/scenes/world.tscn")
	pass # Replace with function body.


func _on_options_button_3_pressed() -> void:
	print("Options sirve")
	pass # Replace with function body.


func _on_exit_button_5_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
