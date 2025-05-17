extends Node2D

@onready var acc_sprite = $Sprite2D

var acc_keys = []
var current_acc_index = 0
var current_color_index = 0

func _ready() -> void:
	SetSprite_keys()
	updateSprite()

func SetSprite_keys():
	acc_keys = Global.acc_options.keys()

func updateSprite():
	var current_sprite = acc_keys[current_acc_index]
	var selected_texture = Global.acc_options[current_sprite]

	acc_sprite.texture = selected_texture

	if selected_texture != null:
		assign_shader_material_if_needed()
		if acc_sprite.material is ShaderMaterial:
			var material := acc_sprite.material as ShaderMaterial
			material.set_shader_parameter("target_color", Global.color_options[current_color_index])
	else:
		acc_sprite.material = null  # si está pelón, quitar shader

	Global.selected_acc = current_sprite
	Global.selected_acc_color = Global.color_options[current_color_index]


func assign_shader_material_if_needed():
	if acc_sprite.material == null:
		var shader := preload("res://Shader/colors.gdshader")
		var mat := ShaderMaterial.new()
		mat.shader = shader
		acc_sprite.material = mat

func randomize():
	current_acc_index = randi() % acc_keys.size()
	current_color_index = randi() % Global.color_options.size()
	updateSprite()

func _on_options_buttom_pressed() -> void:
	current_acc_index = (current_acc_index + 1) % acc_keys.size()
	updateSprite()

func _on_colors_buttom_pressed() -> void:
	current_color_index = (current_color_index + 1) % Global.color_options.size()
	updateSprite()
