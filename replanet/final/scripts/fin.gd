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
	
	await get_tree().create_timer(1.5).timeout

	await hacer_fade(pantalla2, 0.0, 1.0, 0.7)
	await get_tree().create_timer(1).timeout

	await hacer_fade(pantalla1, 1.0, 0.0, 0.7)

	await hacer_fade(pantalla3, 0.0, 1.0, 0.7)
	await get_tree().create_timer(1).timeout
	
	await hacer_fade(pantalla2, 1.0, 0.0, 0.7)
	await get_tree().create_timer(1).timeout

	# Cambio inmediato de escena
	SceneTransitions.change_scene_to_file("res://final/scenes/final.tscn")

func hacer_fade(node: CanvasItem, from_a: float, to_a: float, duration: float) -> void:
	var t: float = 0.0
	while t < duration:
		await get_tree().process_frame
		t += get_process_delta_time()
		var alpha: float = lerp(from_a, to_a, t / duration)
		node.modulate.a = alpha
	node.modulate.a = to_a
