extends CanvasLayer
@onready var puntaje_label = $PuntajeLabel
@onready var palancas_label = $PalancasLabel
# En tu script HUD.gd
@onready var panel_final = $PanelFinal
@onready var mensaje_label = $PanelFinal/Panel/MensajeLabel
@onready var puntaje_final_label = $PanelFinal/Panel/PuntajeFinal
var panel_mostrado := false # Para que solo se muestre una vez

func _process(_delta):
	puntaje_label.text = "Puntaje total: %d" % GameState.puntaje_total
	palancas_label.text = "Palancas activadas: %d / %d" % [
		GameState.palancas_activadas.count(true),
		GameState.palancas_activadas.size()
	]
 # Si se activaron las 3 palancas y aún no mostré el panel final
	if GameState.palancas_activadas.count(true) == 3 and not panel_mostrado:
		mostrar_resultado_finalPanel()
		panel_mostrado = true


func mostrar_resultado_finalPanel():
	puntaje_label.visible = false
	palancas_label.visible = false
	panel_final.visible = true
	puntaje_final_label.text = "Puntos Totales: %d / 1000" % GameState.puntaje_total

	if GameState.puntaje_total >= 1000:
		mensaje_label.text = "¡Has conseguido la estrella!\n¡Atmósfera purificada!"
		# Si tienes un icono de estrella aquí puedes mostrarlo
	else:
		mensaje_label.text = "¡Restauraste el sistema, pero sin suficiente eficiencia para recuperar la estrella!"
		# Si tienes un icono aquí lo puedes ocultar
