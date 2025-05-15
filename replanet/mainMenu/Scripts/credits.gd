extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	var max_scroll = $CreditsText.get_line_count() - $CreditsText.get_visible_line_count()
	var tween = $Tween.create_tween()
	tween.tween_property($CreditsText, "scroll_vertical", max_scroll, 20.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_tregresar_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
	pass # Replace with function body.
