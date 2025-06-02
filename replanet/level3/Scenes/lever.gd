extends Node2D

@export var off_texture: Texture2D
@export var on_texture: Texture2D

var is_player_near := false
var is_on := false

func _ready():
	$Sprite2D.texture = off_texture
	# NO es necesario conectar las señales aquí si lo hiciste por el editor
	# Si NO lo hiciste por el editor, entonces sí:
	# $Area2D.body_entered.connect(_on_area_2d_body_entered)
	# $Area2D.body_exited.connect(_on_area_2d_body_exited)

func _process(_delta):
	if is_player_near and Input.is_action_just_pressed("interact"):
		toggle_lever()

func toggle_lever():
	is_on = not is_on
	$Sprite2D.texture = on_texture if is_on else off_texture
	SceneTransitions.change_scene_to_file("res://level3/Scenes/miniJuego.tscn")
	print("Palanca activada:", is_on)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = true
		print("El jugador está cerca de la palanca")
		$Panel.visible = true # Muestra el panel con el mensaje

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = false
		print("El jugador se alejó de la palanca")
		$Panel.visible = false  # Muestra el panel con el mensaje
