extends Node2D

@onready var pants_sprite = $Sprite2D
 
var pants_keys = []
var color_keys = []
var current_pants_index = 0
var current_color_index = 0

func SetSprite_keys():
	pants_keys = Global.pants_options.keys()

func updateSprite():
	var current_sprite = pants_keys[current_pants_index]
	pants_sprite.texture = Global.pants_options[current_sprite]

	if pants_sprite.material and pants_sprite.material is ShaderMaterial:
		var material := pants_sprite.material as ShaderMaterial
		material.set_shader_parameter("target_color", Global.color_options[current_color_index])

	Global.selected_pants = current_sprite
	Global.selected_pants_color = Global.color_options[current_color_index]

func assign_shader_material_if_needed():
	if pants_sprite.material == null:
		var shader := preload("res://Shader/colors.gdshader")
		var mat := ShaderMaterial.new()
		mat.shader = shader
		pants_sprite.material = mat
		
func randomize():
	current_pants_index = randi() % pants_keys.size()
	current_color_index = randi() % Global.color_options.size()
	updateSprite()

func _ready() -> void:
	assign_shader_material_if_needed()
	SetSprite_keys()
	updateSprite()

func _on_options_buttom_pressed() -> void:
	current_pants_index = (current_pants_index + 1) % pants_keys.size()
	updateSprite()

func _on_colors_buttom_pressed() -> void:
	current_color_index = (current_color_index + 1) % Global.color_options.size()
	updateSprite()
