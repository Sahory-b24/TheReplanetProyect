extends Node

var puntaje_total: int = 0
var niveles_completados: int = 0
var total_niveles: int = 3 # Cambia esto a la cantidad de niveles que tienes

func sumar_puntaje(puntos: int):
	puntaje_total += puntos

func marcar_nivel_completado():
	if niveles_completados < total_niveles:
		niveles_completados += 1

func reiniciar_progreso():
	puntaje_total = 0
	niveles_completados = 0
