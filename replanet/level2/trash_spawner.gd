extends Node2D

@export var trash_scenes: Array[PackedScene] = []
@export var y_range := Vector2(100, 310)
@export var intervalo := 2.0

func _ready():
	$Timer.wait_time = intervalo
	$Timer.start()
	$Timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if trash_scenes.is_empty():
		return
	
	# Escoge una escena al azar
	var random_index = randi() % trash_scenes.size()
	var trash = trash_scenes[random_index].instantiate()

	# Posición (basada en el barco u otra lógica)
	var boat = get_parent().get_node("Boat")
	var spawn_x = boat.position.x + 600
	var spawn_y = randf_range(y_range.x, y_range.y)
	trash.position = Vector2(spawn_x, spawn_y)

	get_parent().add_child(trash)
