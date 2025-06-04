extends Control

@onready var fullscreen_btn = $PantallaCompleta
var is_fullscreen := false

func _ready() -> void:
	$muisc_bar/Control/VBoxContainer/VolumeBar/musicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("music")))
	$Sound_bar/Control/VBoxContainer/VolumeBar/sfxSlider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("sfx")))
	# Establecer el modo de pantalla
	# Sincroniza el botón con la configuración guardada
	is_fullscreen = Settings.fullscreen_enabled
	_update_fullscreen_btn()
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_buttom_back_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")

func _on_music_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"), db)

func _on_sfx_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), db)

func _on_check_button_pressed() -> void:
	var pressed = $CheckButton.button_pressed
	if pressed:
		Overlay.set_mode(1)  # Activar filtro
	else:
		Overlay.set_mode(0)  # Desactivar filtro

func _on_option_button_item_selected(index: int) -> void:
	Overlay.set_mode(index)

func _on_exit_world_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")



func _on_pantalla_completa_pressed() -> void:
	is_fullscreen = !is_fullscreen
	Settings.fullscreen_enabled = is_fullscreen
	_update_fullscreen_btn()
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass # Replace with function body.


func _update_fullscreen_btn():
	if is_fullscreen:
		fullscreen_btn.texture_normal = preload("res://mainMenu/Assets/Buttoms/dalto_icon_ckecked.tres")
	else:
		fullscreen_btn.texture_normal = preload("res://mainMenu/Assets/Buttoms/dalto_icon.tres")
