extends Node2D

@onready var RePlanet: TextureRect = $RePlanet  # tu TextureRect para el logo/nombre
@onready var isla: TextureRect = $isla             # tu TextureRect para la isla

func _ready() -> void:
	# Estado inicial: solo el nombre visible
	RePlanet.modulate.a = 1.0
	isla.modulate.a = 0.0

	# Empieza la secuencia
	mostrar_nombre_y_cambiar()

func mostrar_nombre_y_cambiar() -> void:
	# Espera 2 segundos con el nombre visible
	await get_tree().create_timer(2.0).timeout
	# Fade out del nombre, fade in de la isla
	await hacer_fade(isla, 0.0, 1.0, 1.0)
	# Espera 2 segundos con la isla visible
	await get_tree().create_timer(2.0).timeout
	# Opcional: fade out de la isla
	await hacer_fade(isla, 1.0, 0.0, 1.0)

	# Cambia a la escena del lore
	get_tree().change_scene_to_file("res://InicioLore/scenes/inicioLore.tscn")

func hacer_fade(node: CanvasItem, from_a: float, to_a: float, duration: float) -> void:
	var t: float = 0.0
	while t < duration:
		await get_tree().process_frame
		t += get_process_delta_time()
		var alpha: float = lerp(from_a, to_a, t / duration)
		node.modulate.a = alpha
	node.modulate.a = to_a
