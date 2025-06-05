extends Node2D

@onready var estrellas = [
	$CanvasLayer/HBoxContainer/Star1,
	$CanvasLayer/HBoxContainer/Star2,
	$CanvasLayer/HBoxContainer/Star3,
]
var estrella_llena = preload("res://mainMenu/Assets/Buttoms/StarFull.tres")
var estrella_vacia = preload("res://mainMenu/Assets/Buttoms/StarEmpty.tres")

@onready var label_puntaje = $CanvasLayer/LabelPuntaje
@onready var panel_mensaje = $CanvasLayer/PanelMensaje
@onready var mensaje_inicio = $CanvasLayer/PanelMensaje/MensajeInicio
@onready var timer_mensaje_inicio = $CanvasLayer/PanelMensaje/MensajeInicioTimer

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
		
	mostrar_mensaje_temporal(3.0)

func mostrar_mensaje_temporal(duracion: float):
	panel_mensaje.visible = true
	mensaje_inicio.visible = true
	timer_mensaje_inicio.wait_time = duracion
	timer_mensaje_inicio.start()


func _on_nivel_1_pressed():
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	Global.modo_juego = "PLATAFORMA"
	SceneTransitions.change_scene_to_file("res://level1/Scenes/level_1.tscn")

func _on_nivel_2_pressed():
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	Global.modo_juego = "RPG"
	SceneTransitions.change_scene_to_file("res://level2/Scenes/Level_2.tscn")

func _on_nivel_3_pressed():
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	Global.modo_juego = "RPG"
	SceneTransitions.change_scene_to_file("res://level3/Scenes/level_3.tscn")

	actualizar_estrellas()
	mostrar_puntaje()

func actualizar_estrellas():
	for i in range(GameData.total_niveles):
		estrellas[i].texture = estrella_llena if i < GameData.niveles_completados else estrella_vacia
		
	if GameData.niveles_completados >= GameData.total_niveles:
		Global.modo_juego = "RPG"
		SceneTransitions.change_scene_to_file("res://world2.tscn")

func mostrar_puntaje():
	label_puntaje.text = str(GameData.puntaje_total)


func _on_mensaje_inicio_timer_timeout() -> void:
	panel_mensaje.visible = false
	mensaje_inicio.visible = false


func _on_config_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/Options1.tscn")
	


func _on_atras_mundo_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	GameData.reiniciar_progreso()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/main_menu.tscn")
