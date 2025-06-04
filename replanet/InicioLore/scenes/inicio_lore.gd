extends Node2D

var slides = [
	preload("res://mainMenu/Assets/Images/lore1.png"),
	preload("res://mainMenu/Assets/Images/lore2.png"),
	preload("res://mainMenu/Assets/Images/lore3.png"),
	preload("res://mainMenu/Assets/Images/lore4.png"),
	preload("res://mainMenu/Assets/Images/lore5.png"),
	preload("res://mainMenu/Assets/Images/lore6.png"),
	preload("res://mainMenu/Assets/Images/lore7.png"),
]

var current_slide = 1  # Comenzar desde lore2
var all_labels = []
var slide_labels = []

func _ready() -> void:
	all_labels = [$Label1, $Label2, $Label3, $Label4, $Label5, $Label6, $Label7, $Label8, $Label9, $Label10, $Label11, $Label12]

	slide_labels = {
		1: [$Label1, $Label2],
		2: [$Label3, $Label4],
		3: [$Label5, $Label6],
		4: [$Label7, $Label8],
		5: [$Label9, $Label10],
		6: [$Label11, $Label12],
	}
	
	AudioManager.play_music("res://InicioLore/audio/lluvia-fuerte-182660.mp3")
	# Asegúrate de que el SlideImage tenga modulate = Color(1, 1, 1, 1)
	show_slide(true)

func show_slide(skip_fade := false) -> void:
	# Ocultar todos los labels
	for label in all_labels:
		label.visible = false

	if skip_fade:
		$SlideImage.texture = slides[current_slide]
		if slide_labels.has(current_slide):
			for label in slide_labels[current_slide]:
				label.visible = true
	else:
		var tween = get_tree().create_tween()
		tween.tween_property($SlideImage, "modulate:a", 0.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		await tween.finished

		$SlideImage.texture = slides[current_slide]

		if slide_labels.has(current_slide):
			for label in slide_labels[current_slide]:
				label.visible = true

		# En Godot 4: await create_timer().timeout
		await get_tree().create_timer(0.1).timeout

		var tween2 = get_tree().create_tween()
		tween2.tween_property($SlideImage, "modulate:a", 1.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _on_siguiente_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()

	if current_slide < slides.size() - 1:
		current_slide += 1
		await show_slide()
	else:
		# Ya está en la última diapositiva, ir a escena del mundo
		AudioManager.MusicPlayer.stop()
		SceneTransitions.change_scene_to_file("res://scenes/world.tscn")

func _on_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	
	AudioManager.MusicPlayer.stop()
	SceneTransitions.change_scene_to_file("res://scenes/world.tscn")
