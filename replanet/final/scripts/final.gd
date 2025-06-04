extends Node2D



func _on_main_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	GameData.reiniciar_progreso()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
	
