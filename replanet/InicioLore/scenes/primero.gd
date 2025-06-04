extends Node2D

@onready var RePlanet: TextureRect = $RePlanet
@onready var isla: TextureRect = $isla

func _ready() -> void:
	# Cambiar la música global usando AudioManager
	AudioManager.play_music("res://InicioLore/audio/lluvia-fuerte-182660.mp3")

	# Iniciar secuencia visual
	RePlanet.modulate.a = 1.0
	isla.modulate.a = 0.0
	mostrar_nombre_y_cambiar()

func mostrar_nombre_y_cambiar() -> void:
	await get_tree().create_timer(1.2).timeout
	await hacer_fade(isla, 0.0, 1.0, 1.0)
	await get_tree().create_timer(1.2).timeout
	await hacer_fade(isla, 1.0, 0.0, 1.0)

	SceneTransitions.change_scene_to_file("res://InicioLore/scenes/inicioLore.tscn")

func hacer_fade(node: CanvasItem, from_a: float, to_a: float, duration: float) -> void:
	var t: float = 0.0
	while t < duration:
		await get_tree().process_frame
		t += get_process_delta_time()
		var alpha: float = lerp(from_a, to_a, t / duration)
		node.modulate.a = alpha
	node.modulate.a = to_a
