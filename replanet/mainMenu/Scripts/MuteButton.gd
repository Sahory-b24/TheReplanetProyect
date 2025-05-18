extends TextureButton

const ICON_SOUND_ON = preload("res://mainMenu/Assets/Buttoms/Mute.tres")
const ICON_SOUND_OFF = preload("res://mainMenu/Assets/Buttoms/unMute.tres")

func _ready():
	update_icon()
	connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
	AudioManager.toggle_music()
	update_icon()

func update_icon():
	if AudioManager.music_muted:
		texture_normal = ICON_SOUND_OFF
	else:
		texture_normal = ICON_SOUND_ON


func _on_buttom_back_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
