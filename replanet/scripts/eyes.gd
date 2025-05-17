extends Node2D

@onready var eyes_sprite = $Sprite2D
 
var eyes_keys = []
var color_keys = []
var current_eyes_index = 0
var current_color_index = 0

func SetSprite_keys():
	eyes_keys = Global.eyes.keys()
	
func updateSprite():
	var current_sprite = eyes_keys[current_eyes_index]
	eyes_sprite.texture = Global.eyes[current_sprite]
	eyes_sprite.modulate = Global.color_options[current_color_index]
	
	Global.selected_eyes = current_sprite
	Global.selected_eyes_color = Global.color_options[current_color_index]
	
func randomize():
	current_eyes_index = randi() % eyes_keys.size()
	current_color_index = randi() % Global.color_options.size()
	updateSprite()

func _ready() -> void:
	SetSprite_keys()
	updateSprite()

func _on_options_buttom_pressed() -> void:
	current_color_index = (current_color_index + 1 )% Global.color_options.size()
	updateSprite()
	
