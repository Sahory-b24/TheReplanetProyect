extends Node2D

<<<<<<< HEAD
# Lista de imágenes
var slides = [
	preload("res://mainMenu/Assets/Images/slide1.png"),
	preload("res://mainMenu/Assets/Images/slide2.png"),
]

# Lista de textos por diapositiva
var slide_texts = [
	["Moverse", "Saltar"],
	["Inventario", "Recolectar"],
	
]

var current_slide = 0

func _ready():
	show_slide()

func _process(delta: float) -> void:
	pass

func show_slide():
	$SlideImage.texture = slides[current_slide]
	$Label1.text = ""
	$Label2.text = ""

	if slide_texts[current_slide].size() > 0:
		$Label1.text = slide_texts[current_slide][0]
	if slide_texts[current_slide].size() > 1:
		$Label2.text = slide_texts[current_slide][1]

	$atrasButton.disabled = current_slide == 0
	$siguienteButton.disabled = current_slide == slides.size() - 1

=======

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

>>>>>>> ce29b5c1b698c860ab16d809b10ab9dc9605ab01

func _on_regresar_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
<<<<<<< HEAD


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
=======
	pass # Replace with function body.
>>>>>>> ce29b5c1b698c860ab16d809b10ab9dc9605ab01
