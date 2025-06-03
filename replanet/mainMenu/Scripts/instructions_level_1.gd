extends Node2D

func _process(delta: float) -> void:
	pass

func _on_back_level_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://level1/Scenes/level_1.tscn")
