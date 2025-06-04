extends Node2D

@onready var pantalla1: TextureRect = $pantalla1
@onready var pantalla2: TextureRect = $pantalla2
@onready var pantalla3: TextureRect = $pantalla3

func _ready() -> void:
	AudioManager.play_music("res://mainMenu/Assets/Audio/On the Farm.wav")
	pantalla1.modulate.a = 1.0
	pantalla2.modulate.a = 0.0
	pantalla3.modulate.a = 0.0
	mostrar_secuencia()

func mostrar_secuencia() -> void:
	# Mostrar la primera pantalla por 2 segundos
	await get_tree().create_timer(2).timeout

	# Fade in de la segunda pantalla
	await hacer_fade(pantalla2, 0.0, 1.0, 1.0)
	await get_tree().create_timer(2).timeout

	# Fade out de la primera pantalla
	await hacer_fade(pantalla1, 1.0, 0.0, 1.0)

	# Fade in de la tercera pantalla
	await hacer_fade(pantalla3, 0.0, 1.0, 1.0)
	await get_tree().create_timer(2).timeout

	# Fade out de la segunda pantalla
	await hacer_fade(pantalla2, 1.0, 0.0, 1.0)
	await get_tree().create_timer(2).timeout

	# Cambio inmediato de escena
	SceneTransitions.change_scene_to_file("res://scenes/Custimization.tscn")

func hacer_fade(node: CanvasItem, from_a: float, to_a: float, duration: float) -> void:
	var t: float = 0.0
	while t < duration:
		await get_tree().process_frame
		t += get_process_delta_time()
		var alpha: float = lerp(from_a, to_a, t / duration)
		node.modulate.a = alpha
	node.modulate.a = to_a
