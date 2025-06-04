extends CanvasLayer

@onready var puntaje_label = $PuntajeLabel
@onready var panel_final = $Panel
@onready var mensaje_label = $Panel/Panel2/mensaje_label
@onready var puntaje_final_label  = $Panel/Panel2/PuntajeFinal

func _ready():
	panel_final.visible = false

func mostrar_panel_final(puntaje: int):
	panel_final.visible = true
	puntaje_final_label.text = "Puntaje: %d" % puntaje

	if puntaje >= 1300:
		mensaje_label.text = "Excelente, hiciste un buen trabajo limpiando el río. 
Te ganaste una estrella."
		GameData.sumar_puntaje(puntaje)
		GlobalWorld.nivel_2_jugado = true
		GameData.marcar_nivel_completado()
	else:
		mensaje_label.text = "No alcanzaste el puntaje necesario."

	# Guardar puntaje
	GuardarPuntaje.guardar_puntaje_nivel1(Global.player_name, puntaje)


func _on_atras_mundo_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://scenes/world.tscn")


func _on_mecanica_2_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/instructions_level2.tscn")
