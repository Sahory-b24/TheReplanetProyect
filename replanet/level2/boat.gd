extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.play("boat")
	

@export var speed: float = 50.0
@export var follow_speed: float = 5.0  # Qué tan rápido sigue al mouse
@export var min_y: float = 70.0
@export var max_y: float = 280.0

func _process(delta):
	# Mueve en X (automático hacia la derecha)
	position.x += speed * delta

	# Mueve en Y hacia la posición del mouse, pero limitado
	var mouse_y = get_viewport().get_mouse_position().y
	var target_y = clamp(mouse_y, min_y, max_y) 
	position.y = lerp(position.y, target_y, follow_speed * delta)
	
