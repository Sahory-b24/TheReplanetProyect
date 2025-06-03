extends Node2D

# Lista de imágenes (precarga los recursos)
var slides = [
	preload("res://mainMenu/Assets/Images/slide1.png"),
	preload("res://mainMenu/Assets/Images/slide2.png"),
]

# Lista de textos por diapositiva
var slide_texts = [
	["Saltar", "Moverse"],
	["Inventario", "Recolectar"],
]

var current_slide = 0

func _ready() -> void:
	show_slide()

func _process(delta: float) -> void:
	pass

func show_slide() -> void:
	$SlideImage.texture = slides[current_slide]
	$Label1.text = ""
	$Label2.text = ""

	if slide_texts[current_slide].size() > 0:
		$Label1.text = slide_texts[current_slide][0]
	if slide_texts[current_slide].size() > 1:
		$Label2.text = slide_texts[current_slide][1]

	$atrasButton.disabled = current_slide == 0
	$siguienteButton.disabled = current_slide == slides.size() - 1

func _on_regresar_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")

func _on_atras_button_pressed() -> void:
	if current_slide > 0:
		current_slide -= 1
		show_slide()
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()

func _on_siguiente_button_pressed() -> void:
	if current_slide < slides.size() - 1:
		current_slide += 1
		show_slide()
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
