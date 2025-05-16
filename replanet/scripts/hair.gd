extends Node2D

@onready var hair_sprite = $Sprite2D

var hair_keys = []
var current_hair_index = 0
var current_color_index = 0

func _ready() -> void:
	SetSprite_keys()
	updateSprite()

func SetSprite_keys():
	hair_keys = Global.hair_options.keys()

func updateSprite():
	var current_sprite = hair_keys[current_hair_index]
	var selected_texture = Global.hair_options[current_sprite]

	hair_sprite.texture = selected_texture

	if selected_texture != null:
		assign_shader_material_if_needed()
		if hair_sprite.material is ShaderMaterial:
			var material := hair_sprite.material as ShaderMaterial
			material.set_shader_parameter("target_color", Global.hair_color_options[current_color_index])
	else:
		hair_sprite.material = null  # No shader si no hay textura

	Global.selected_hair = current_sprite
	Global.selected_hair_color = Global.hair_color_options[current_color_index]

func assign_shader_material_if_needed():
	if hair_sprite.material == null:
		var shader := preload("res://Shader/colors.gdshader")
		var mat := ShaderMaterial.new()
		mat.shader = shader
		hair_sprite.material = mat

func randomize():
	current_hair_index = randi() % hair_keys.size()
	current_color_index = randi() % Global.hair_color_options.size()
	updateSprite()

func _on_options_buttom_pressed() -> void:
	current_hair_index = (current_hair_index + 1) % hair_keys.size()
	updateSprite()

func _on_colors_buttom_pressed() -> void:
	current_color_index = (current_color_index + 1) % Global.hair_color_options.size()
	updateSprite()
