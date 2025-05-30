extends Label

@onready var score_manager = get_parent().get_node("ScoreManager")

func _ready():
	if score_manager:
		score_manager.connect("score_updated", Callable(self, "_on_score_updated"))
	else:
		print("❌ ScoreManager no encontrado")

func _on_score_updated(new_score: int) -> void:
	text = "Puntaje: %d" % new_score
