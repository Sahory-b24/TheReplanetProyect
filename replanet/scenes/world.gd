extends Node2D


func _on_nivel_1_pressed() -> void:
	Global.modo_juego = "PLATAFORMA"
	get_tree().change_scene_to_file("res://level1/Scenes/level_1.tscn")
	
func _on_nivel_2_pressed() -> void:
	Global.modo_juego = "RPG"
	get_tree().change_scene_to_file("res://level2/Scenes/Level_2.tscn")
	
func _on_nivel_3_pressed() -> void:
	Global.modo_juego = "RPG"
	get_tree().change_scene_to_file("res://level3/Scenes/level_3.tscn")


func _on_config_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/config.tscn")
