extends CanvasLayer

var seeds = 0

func _ready():
	
	var wonArea = get_tree().current_scene.get_node("wonArea2D")
	if wonArea and wonArea.has_signal("level_won"):
		wonArea.connect("level_won", Callable(self, "mostrar_ganaste"))
	#print("UI lista")
	var seeds_nodes = get_tree().current_scene.find_children("", "", true, false)
	#print("Escena actual:", get_tree().current_scene.name)
	for child in get_tree().current_scene.get_children():
		if child.name.begins_with("Seed"):
			var area = child.get_node("Seed2D") # para la semilla normal
			if area and area.has_signal("seedCollected"):
				area.connect("seedCollected", Callable(self, "handleSeedCollected"))
		elif child.name.begins_with("bonusSeed"):
			var area = child.get_node("bonusSeed2D") # para la semilla bonus
			if area and area.has_signal("seedCollected"):
				area.connect("seedCollected", Callable(self, "handleSeedCollected"))
		elif child.name.begins_with("Mushroom"):
			var area = child.get_node("Mushroom2D")
			if area and area.has_signal("mushroomTouched"):
				area.connect("mushroomTouched", Callable(self, "handleSeedCollected"))
	$seedsCollected.text = str(seeds)

func handleSeedCollected(seed_name):
	
	if seed_name.begins_with("bonusSeed"):
		seeds+= 200
		#print("HOLA")
	elif seed_name.begins_with("Seed"):
		seeds+=100
		#print(seeds)
	elif seed_name.begins_with("Mushroom"):
		seeds-=150
	$seedsCollected.text = str(seeds)
	
func mostrar_ganaste():
	$WonPanel.visible = true
	$WonPanel/TextureRect/puntajeLabel.text = str(seeds)
	GameData.sumar_puntaje(seeds)
	GlobalWorld.nivel_1_jugado = true
	GameData.marcar_nivel_completado()
	get_tree().paused = true
	GuardarPuntaje.guardar_puntaje_nivel1(Global.player_name, seeds)
	


func _on_back_main_pressed() -> void:
	get_tree().paused = false
	Global.modo_juego = "RPG"
	SceneTransitions.change_scene_to_file("res://scenes/world.tscn")
