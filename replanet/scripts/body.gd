extends Node2D

@onready var body_sprite = $Sprite2D
 
var body_keys = []
var current_body_index = 0

func SetSprite_keys():
	body_keys = Global.body_options.keys()
	
func updateSprite():
	var current_sprite = body_keys[current_body_index]
	body_sprite.texture = Global.body_options[current_sprite]
	
	Global.selected_body = current_sprite

func randomize():
	current_body_index = randi() % body_keys.size()
	updateSprite()

func _ready() -> void:
	SetSprite_keys()
	updateSprite()

func _on_options_buttom_pressed() -> void:
	current_body_index = (current_body_index + 1) % body_keys.size()
	updateSprite()
