extends CharacterBody2D

@export var speed: float = 50.0
@export var follow_speed: float = 5.0
@export var min_y: float = 70.0
@export var max_y: float = 280.0
@onready var cooldown_timer: Timer = $DamageCooldown
var switch := true

func _ready():
	$AnimatedSprite2D.play("boat")

func _physics_process(delta):
	# Movimiento automático en X (sin colisiones)
	position.x += speed * delta

	# Movimiento en Y con colisiones
	var mouse_y = get_viewport().get_mouse_position().y
	var target_y = clamp(mouse_y, min_y, max_y)

	var direction_y = target_y - position.y
	var velocity_y = direction_y * follow_speed
	var movement = Vector2(0, velocity_y * delta)

	var collision = move_and_collide(movement)
	if collision and switch:
		# Restar puntos si ScoreManager está presente
		var score_manager = get_tree().current_scene.get_node("CanvasLayer/ScoreManager")
		if score_manager:
			score_manager.add_points(-30)  # ❌ Resta 30 puntos
			
		switch = false
		cooldown_timer.start()


func _on_damage_cooldown_timeout() -> void:
	switch = true
