extends Node

var score: int = 0
var max_score: int = 1300
var finished: bool = false
signal score_updated(new_score: int)

func add_points(points: int) -> void:
	if finished:
		return  # Ya se alcanzó el máximo, no sumar más puntos

	score += points
	if score >= max_score:
		score = max_score
		finished = true
		emit_signal("score_updated", score)
		mostrar_final()
	else:
		emit_signal("score_updated", score)

func mostrar_final():
	var canvas = get_tree().current_scene.get_node("CanvasLayer")
	if canvas:
		canvas.mostrar_panel_final(score)
