extends Node2D

@export var goal_score: int = 1300
@export var level_end_x: float = 4245.0  # Ajusta al ancho de tu mapa
@onready var boat = $"../Boat"
@onready var score_manager = $"../CanvasLayer/ScoreManager"
var nombre = Global.player_name

func _ready():
	score_manager.score_updated.connect(_on_score_updated)

func _process(delta):
	# Finaliza si el barco llega al final del mapa
	if boat.position.x >= level_end_x:
		_end_level(false)

func _on_score_updated(score: int) -> void:
	if score >= goal_score:
		_end_level(true)

func _end_level(success: bool) -> void:
	if success:
		GuardarPuntaje.guardar_puntaje(nombre, score_manager.score)
		get_tree().change_scene_to_file("res://level2/Scenes/Puntajes.tscn")
