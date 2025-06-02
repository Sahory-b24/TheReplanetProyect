extends Node

var score: int = 0

signal score_updated(new_score: int)

func add_points(points: int) -> void:
	score += points
	emit_signal("score_updated", score)
