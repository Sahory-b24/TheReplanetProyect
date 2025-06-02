extends Node2D

#func _ready():
	#AudioManager.play_music("res://mainMenu/Assets/Audio/Dark Ambient 1.wav")

func _on_nivel_1_pressed() -> void:
	Global.modo_juego = "PLATAFORMA"
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	
func _on_nivel_2_pressed() -> void:
	Global.modo_juego = "RPG"
	get_tree().change_scene_to_file("res://level2/Scenes/Level_2.tscn")
	
func _on_nivel_3_pressed() -> void:
	Global.modo_juego = "RPG"
	get_tree().change_scene_to_file("res://level3/Scenes/level_3.tscn")
