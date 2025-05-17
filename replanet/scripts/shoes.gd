extends Node2D

@onready var shoes_sprite = $Sprite2D
 
var shoes_keys = []
var color_keys = []
var current_shoes_index = 0
var current_color_index = 0

func SetSprite_keys():
	shoes_keys = Global.shoes.keys()
	
func updateSprite():
	var current_sprite = shoes_keys[current_shoes_index]
	shoes_sprite.texture = Global.shoes[current_sprite]
	shoes_sprite.modulate = Global.color_options[current_color_index]
	
	Global.selected_shoes = current_sprite
	Global.selected_shoes_color = Global.color_options[current_color_index]
	
func randomize():
	current_color_index = randi() % Global.color_options.size()
	updateSprite()

func _ready() -> void:
	SetSprite_keys()
	updateSprite()


func _on_options_buttom_pressed() -> void:
	current_shoes_index = (current_shoes_index + 1) % shoes_keys.size()
	updateSprite()

func _on_colors_buttom_pressed() -> void:
	current_color_index = (current_color_index + 1 )% Global.color_options.size()
	updateSprite()
