extends Area2D
class_name NPC

@export var nombre: String = "NPC"
@export var dialogo_path: Resource  # Asigna diferente .dialogue en cada NPC
@export var sprite: Texture2D       # Asigna sprite diferente en cada NPC

static var npc_activo = null        # Este será el único NPC que responde

@onready var sprite_node := $Sprite2D

func _ready():
	if sprite:
		sprite_node.texture = sprite
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":  
		NPC.npc_activo = self  # Este NPC se vuelve el activo

func _on_body_exited(body):
	if body.name == "Player" and NPC.npc_activo == self:
		NPC.npc_activo = null

func _process(_delta):
	if NPC.npc_activo == self and Input.is_action_just_pressed("ui_accept"):
		mostrar_dialogo()

func mostrar_dialogo():
	if dialogo_path:
		DialogueManager.show_example_dialogue_balloon(dialogo_path)
