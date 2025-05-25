extends Node2D

#func _ready():
	#AudioManager.play_music("res://mainMenu/Assets/Audio/Dark Ambient 1.wav")

func _on_nivel_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	
func _on_nivel_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_2.tscn")
	
func _on_nivel_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_3.tscn")
