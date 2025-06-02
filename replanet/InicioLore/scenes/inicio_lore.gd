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

var current_slide = 1
var all_labels = []
var slide_labels = {}

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

	show_slide()

func show_slide() -> void:
	$SlideImage.texture = slides[current_slide]

	for label in all_labels:
		if label:
			label.visible = false

	if slide_labels.has(current_slide):
		for label in slide_labels[current_slide]:
			if label:
				label.visible = true

func _on_siguiente_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()

	if current_slide < slides.size() - 1:
		current_slide += 1
		show_slide()
	else:
		# Ya está en la última slide, ahora cambiamos de escena
		SceneTransitions.change_scene_to_file("res://scenes/world.tscn")


func _on_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://scenes/world.tscn.tscn")
	pass # Replace with function body.
