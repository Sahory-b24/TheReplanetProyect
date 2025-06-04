extends Node2D

@export var off_texture: Texture2D
@export var on_texture: Texture2D
@export var lever_id : int = 0

var is_player_near := false
var is_on := false

func _ready():
	if GameState.palancas_activadas[lever_id]:
		is_on = true
		$Sprite2D.texture = on_texture
	else:
		is_on = false
		$Sprite2D.texture = off_texture


func _process(_delta):
	if is_player_near and Input.is_action_just_pressed("interact"):
		toggle_lever()



func toggle_lever():
	if is_on or GameState.palancas_activadas[lever_id]:
		return
	is_on = true
	$Sprite2D.texture = on_texture
	activar_minijuego()
	print("Palanca activada:", is_on)


func activar_minijuego():
	GameState.current_lever_id = self.lever_id
	GameState.player_position = get_tree().current_scene.get_node("Player").global_position
	SceneTransitions.change_scene_to_file("res://level3/Scenes/miniJuego.tscn")


func _on_minijuego_completado(puntos,exito):
	if exito:
		GameState.palancas_activadas[lever_id] = true
		GameState.puntaje_palancas[lever_id] = puntos
		GameState.puntaje_total = GameState.puntaje_palancas.sum()
		print("Minijuego de palanca ", lever_id, " completado con ", puntos, " puntos.")
	else:
		print("Minijuego de palanca ", lever_id, " fallido o incompleto.")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = true
		$Panel.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = false
		$Panel.visible = false
