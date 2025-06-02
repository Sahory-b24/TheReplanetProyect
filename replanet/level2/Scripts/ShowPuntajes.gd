extends Control

@onready var score_list = $VBoxContainer/ScoreList

func _ready():
	var puntajes = GuardarPuntaje.cargar_puntajes()
	print("se cargo la lista de puntajes")
	for linea in puntajes:
		var label = Label.new()
		label.text = linea
		score_list.add_child(label)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
