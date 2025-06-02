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

var current_slide = 0

# Todos los labels en la escena
var all_labels = []

# Diccionario que asigna qué labels mostrar en cada slide
var slide_labels = {}

func _ready() -> void:
	# Inicializamos las referencias de labels
	all_labels = [$Label1, $Label2, $Label3, $Label4,  $Label5,  $Label6,  $Label7,  $Label8,  $Label9,  $Label10,  $Label11,  $Label12]

	# Mapeamos los slides con sus respectivos labels
	slide_labels = {
		1: [$Label1, $Label2], # lore2.png
		2: [$Label3, $Label4], # lore3.png
		3: [$Label5, $Label6], # lore4.png
		4: [$Label7, $Label8], # lore5.png
		5: [$Label9, $Label10], # lore6.png
		6: [$Label11, $Label12], # lore7.png
	}

	show_slide()

func show_slide() -> void:
	$SlideImage.texture = slides[current_slide]

	# Ocultamos todos los labels
	for label in all_labels:
		if label:
			label.visible = false

	# Mostramos los labels que correspondan al slide actual
	if slide_labels.has(current_slide):
		for label in slide_labels[current_slide]:
			if label:
				label.visible = true

	# Botones de navegación
	$atrasButton.disabled = current_slide == 0
	$siguienteButton.disabled = current_slide == slides.size() - 1

func _on_siguiente_button_pressed() -> void:
	if current_slide < slides.size() - 1:
		current_slide += 1
		show_slide()
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()

func _on_atras_button_pressed() -> void:
	if current_slide > 0:
		current_slide -= 1
		show_slide()
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()

func _on_buttom_back_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
