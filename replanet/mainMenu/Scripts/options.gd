extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$muisc_bar/Control/VBoxContainer/VolumeBar/musicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")))
	$Sound_bar/Control/VBoxContainer/VolumeBar/sfxSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("sfx")))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_buttom_back_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
	pass


func _on_music_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), db)
	pass # Replace with function body.


func _on_sfx_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear_to_db(value))
	pass # Replace with function body.


func _on_check_button_pressed() -> void:
	var pressed = $CheckButton.button_pressed
	if pressed:
		Overlay.set_mode(1)  # Activar filtro
	else:
		Overlay.set_mode(0)  # Desactivar filtro




func _on_option_button_item_selected(index: int) -> void:
	Overlay.set_mode(index)
	

func _on_exit_world_button_pressed() -> void:
	SceneTransitions.change_scene_to_file("res://scenes/world.tscn")
