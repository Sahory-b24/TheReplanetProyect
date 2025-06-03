extends CanvasLayer
@onready var puntaje_label = $PuntajeLabel
@onready var palancas_label = $PalancasLabel

func _process(_delta):
	puntaje_label.text = "Puntaje total: %d" % GameState.puntaje_total
	palancas_label.text = "Palancas activadas: %d / %d" % [
		GameState.palancas_activadas.count(true),
		GameState.palancas_activadas.size()
	]
