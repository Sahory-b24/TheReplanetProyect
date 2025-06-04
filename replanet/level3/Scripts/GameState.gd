extends Node

var palancas_activadas = [false, false, false] # Una entrada por palanca (puede ser por ID o índice)
var puntaje_palancas = [0, 0, 0] # Un puntaje por palanca
var puntaje_total = 0
var player_position = Vector2.ZERO
var current_lever_id := -1
var nivel3_registrado := false

func reset():
	palancas_activadas = [false, false, false]
	puntaje_palancas = [0, 0, 0]
	puntaje_total = 0
	player_position = Vector2.ZERO
	nivel3_registrado = false
