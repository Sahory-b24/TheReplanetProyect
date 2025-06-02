extends Area2D

@export var speed := 50.0  # velocidad de movimiento

func _ready():
	$AnimatedSprite2D.play("float") 
	connect("area_entered", self._on_area_entered)
	
func _physics_process(delta):
	position.x -= speed * delta  # se mueve hacia el jugador

	
func _on_area_entered(area):
		get_tree().current_scene.get_node("CanvasLayer/ScoreManager").add_points(50)
		queue_free()
		print("♻️ ¡Basura recolectada!")
