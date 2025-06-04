extends Node2D

@onready var panel_mensaje = $CanvasLayer/Panel
@onready var mensaje_inicio = $CanvasLayer/Panel/Label

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		activar_portal()

func activar_portal():
	# Cambia aquí la ruta a tu escena destino
	SceneTransitions.change_scene_to_file("res://final/scenes/fin.tscn")


func _on_config_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/Options1.tscn")


func _on_atras_mundo_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	GameData.reiniciar_progreso()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
