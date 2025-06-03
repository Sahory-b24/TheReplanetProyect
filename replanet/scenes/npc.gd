extends Area2D
class_name NPC

@export var nombre: String = "NPC"
@export var dialogo_path: Resource
@export var sprite: Texture2D

static var npc_activo = null

@onready var sprite_node := $Sprite2D
@onready var interact_panel := $Panel

func _ready():
	if sprite:
		sprite_node.texture = sprite
	interact_panel.visible = false
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		NPC.npc_activo = self
		interact_panel.visible = true  # Mostrar panel

func _on_body_exited(body):
	if body.name == "Player" and NPC.npc_activo == self:
		NPC.npc_activo = null
		interact_panel.visible = false  # Ocultar panel

func _process(_delta):
	if NPC.npc_activo == self and Input.is_action_just_pressed("ui_accept"):
		mostrar_dialogo()
		interact_panel.visible = false  # Puedes ocultar el panel al interactuar si quieres

func mostrar_dialogo():
	if dialogo_path:
		DialogueManager.show_example_dialogue_balloon(dialogo_path)
