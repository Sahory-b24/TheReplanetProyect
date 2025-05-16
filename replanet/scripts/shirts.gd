extends Node2D

@onready var shirts_sprite = $Sprite2D
 
var shirts_keys = []
var color_keys = []
var current_shirts_index = 0
var current_color_index = 0

func SetSprite_keys():
	shirts_keys = Global.shirts_options.keys()
	
func updateSprite():
	var current_sprite = shirts_keys[current_shirts_index]
	shirts_sprite.texture = Global.shirts_options[current_sprite]


	if shirts_sprite.material and shirts_sprite.material is ShaderMaterial:
		var material := shirts_sprite.material as ShaderMaterial
		material.set_shader_parameter("target_color", Global.color_options[current_color_index])

	Global.selected_shirt = current_sprite
	Global.selected_shirt_color = Global.color_options[current_color_index]
	
func assign_shader_material_if_needed():
	if shirts_sprite.material == null:
		var shader := preload("res://Shader/colors.gdshader")
		var mat := ShaderMaterial.new()
		mat.shader = shader
		shirts_sprite.material = mat

func randomize():
	current_shirts_index = randi() % shirts_keys.size()
	current_color_index = randi() % Global.color_options.size()
	updateSprite()

func _ready() -> void:
	assign_shader_material_if_needed()
	SetSprite_keys()
	updateSprite()


func _on_options_buttom_pressed() -> void:
	current_shirts_index = (current_shirts_index + 1) % shirts_keys.size()
	updateSprite()

func _on_colors_buttom_pressed() -> void:
	current_color_index = (current_color_index + 1 )% Global.color_options.size()
	updateSprite()
