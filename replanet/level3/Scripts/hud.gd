extends CanvasLayer

@onready var puntaje_label = $PuntajeLabel
@onready var puntaje_rect = $PuntajeRect
@onready var panel_final = $Panel2
@onready var mensaje_label = $Panel2/PanelFinal/Panel/MensajeLabel
@onready var puntaje_final_label = $Panel2/PanelFinal/Panel/PuntajeFinal
@onready var atrasMundo = $atrasMundo
@onready var reintentar_button = $Panel2/ReintentarButton
@onready var stars = [
	$PalancasContainer/Energy1,
	$PalancasContainer/Energy2,
	$PalancasContainer/Energy3
]

var texture_full = preload("res://level3/Assets/textures/EnergyFull.tres")
var texture_empty = preload("res://level3/Assets/textures/EnergyEmpty.tres")

var panel_mostrado := false

func _ready():
	panel_final.visible = false
	actualizar_palancas_visual()

func _process(_delta):
	puntaje_label.text = "X %d" % GameState.puntaje_total
	actualizar_palancas_visual()

	if GameState.palancas_activadas.count(true) == 3 and not panel_mostrado:
		mostrar_resultado_finalPanel()
		panel_mostrado = true

func mostrar_resultado_finalPanel():
	puntaje_label.visible = false
	puntaje_rect.visible = true
	panel_final.visible = true
	atrasMundo.visible=false
	puntaje_final_label.text = "Puntos Totales: %d / 1000" % GameState.puntaje_total

	if GameState.puntaje_total >= 1000:
		mensaje_label.text = "¡Has conseguido la estrella!\n¡Atmósfera purificada!"
		reintentar_button.visible = false
		if not GameState.nivel3_registrado:
			GameData.sumar_puntaje(GameState.puntaje_total)
			GlobalWorld.nivel_3_jugado = true
			GameData.marcar_nivel_completado()
			GameState.nivel3_registrado = true
		
	else:
		mensaje_label.text = "¡Restauraste el sistema, pero sin suficiente eficiencia para recuperar la estrella!"
		reintentar_button.visible = true
	GuardarPuntaje.guardar_puntaje_nivel3(Global.player_name, GameState.puntaje_total)
	atrasMundo.visible=true
	
func actualizar_palancas_visual():
	for i in range(stars.size()):
		if i < GameState.palancas_activadas.size() and GameState.palancas_activadas[i]:
			stars[i].texture = texture_full
		else:
			stars[i].texture = texture_empty

func _on_volver_al_mundo_pressed() -> void:
	SceneTransitions.change_scene_to_file("res://scenes/world.tscn")



func _on_mecanica_3_button_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()
	GameState.player_position = get_tree().current_scene.get_node("Player").global_position
	SceneTransitions.change_scene_to_file("res://mainMenu/Scenes/instructions_level3.tscn")


func _on_atras_mundo_pressed() -> void:
	AudioManager.SFXPlayer.stream = preload("res://mainMenu/Assets/Audio/tf2-button-click-hover.mp3")
	AudioManager.SFXPlayer.play()	
	SceneTransitions.change_scene_to_file("res://scenes/world.tscn")
	


func _on_reintentar_button_pressed() -> void:
	puntaje_rect.visible = false
	panel_final.visible = false
	GameState.reset()
	get_tree().reload_current_scene()
	pass # Replace with function body.
