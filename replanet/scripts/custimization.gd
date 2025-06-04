extends Node2D

@onready var name_box = $Customization_screen/Panel/Name/TextEdit
@onready var mensaje = $Customization_screen/Panel/Name/MENSAJE

var player_name = ""

func _on_text_edit_text_changed() -> void:
	player_name = name_box.text.strip_edges()
	mensaje.visible = false  # Oculta el mensaje mientras escribe

func _on_save_buttom_pressed() -> void:
	if player_name == "":
		mensaje.text = "⚠️ INGRESE NOMBRE"
		mensaje.visible = true
		return  # No continúa si no hay nombre

	Global.player_name = player_name
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	get_tree().change_scene_to_file("res://InicioLore/scenes/primero.tscn")

func _on_random_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	var paths = [
		"Body",
		"Hair",
		"Shirts",
		"Pants",
		"Shoes",
		"acc",
		"eyes",
	]

	var character = $".".get_node("Character")
	for path in paths:
		var node = character.get_node_or_null(path)
		if node != null and node.has_method("randomize"):
			node.randomize()

func _on_buttom_back_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
