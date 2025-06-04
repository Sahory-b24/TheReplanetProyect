extends Node2D

@onready var estrellas = [
	$CanvasLayer/HBoxContainer/Star1,
	$CanvasLayer/HBoxContainer/Star2,
	$CanvasLayer/HBoxContainer/Star3,
]
var estrella_llena = preload("res://mainMenu/Assets/Buttoms/StarFull.tres")
var estrella_vacia = preload("res://mainMenu/Assets/Buttoms/StarEmpty.tres")

@onready var label_puntaje = $CanvasLayer/LabelPuntaje


@onready var nivel_1_btn = $Nivel1
@onready var nivel_2_btn = $Nivel2
@onready var nivel_3_btn = $Nivel3

func _ready():
	AudioManager.play_music("res://mainMenu/Assets/Audio/On the Farm.wav")
	actualizar_estrellas()
	mostrar_puntaje()
	if GlobalWorld.nivel_1_jugado:
		nivel_1_btn.disabled = true
	if GlobalWorld.nivel_2_jugado:
		nivel_2_btn.disabled = true
	if GlobalWorld.nivel_3_jugado:
		nivel_3_btn.disabled = true

func _on_nivel_1_pressed():
	Global.modo_juego = "PLATAFORMA"
	get_tree().change_scene_to_file("res://level1/Scenes/level_1.tscn")

func _on_nivel_2_pressed():
	Global.modo_juego = "RPG"
	get_tree().change_scene_to_file("res://level2/Scenes/level_2.tscn")

func _on_nivel_3_pressed():
	Global.modo_juego = "RPG"
	get_tree().change_scene_to_file("res://level3/Scenes/level_3.tscn")

	actualizar_estrellas()
	mostrar_puntaje()

func actualizar_estrellas():
	for i in range(GameData.total_niveles):
		estrellas[i].texture = estrella_llena if i < GameData.niveles_completados else estrella_vacia

func mostrar_puntaje():
	label_puntaje.text = str(GameData.puntaje_total)

func _on_config_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	get_tree().change_scene_to_file("res://mainMenu/Scenes/Options1.tscn")


func _on_atras_mundo_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	GameData.reiniciar_progreso()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
	
