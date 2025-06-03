extends Area2D

class_name NPC

@export var nombre: String = "NPC"
@export var dialogo_path: Resource  # Cargar el .dialogue aquí
@export var sprite: Texture2D       # Sprite diferente por cada NPC

var jugador_cerca = false

@onready var sprite_node := $Sprite2D

func _ready():
	if sprite:
		sprite_node.texture = sprite
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	print("body_entered: ", body.name, " - tipo: ", body)
	jugador_cerca = true

func _on_body_exited(body):
	print("body_exited: ", body.name, " - tipo: ", body)
	jugador_cerca = false

func _process(_delta):
	if jugador_cerca and Input.is_action_just_pressed("ui_accept"):
		mostrar_dialogo()

func mostrar_dialogo():
	if dialogo_path:
		DialogueManager.show_example_dialogue_balloon(dialogo_path)
