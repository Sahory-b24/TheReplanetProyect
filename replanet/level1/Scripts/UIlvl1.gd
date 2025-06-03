extends CanvasLayer

var seeds = 0

func _ready():
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
	$seedsCollected.text = str(seeds)

func handleSeedCollected(seed_name):
	
	if seed_name.begins_with("bonusSeed"):
		seeds+= 200
		#print("HOLA")
	else:
		seeds+=100
		#print(seeds)
	$seedsCollected.text = str(seeds)
