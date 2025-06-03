extends CanvasLayer

@onready var panel_final = $Panel/Panel2
@onready var mensaje_label = $Panel/Panel2/mensaje_label
@onready var puntaje_final_label = $Panel/Panel2/puntaje_final_label

func mostrar_panel_final(exito: bool, puntaje: int):
	panel_final.visible = true
	puntaje_final_label.text = "Puntaje: %d" % puntaje
	if exito:
		mensaje_label.text = "¡Nivel completado!"
	else:
		mensaje_label.text = "No alcanzaste el puntaje necesario."


func _on_atras_mundo_pressed() -> void:
	SceneTransitions.change_scene_to_file("res://scenes/world.tscn")
