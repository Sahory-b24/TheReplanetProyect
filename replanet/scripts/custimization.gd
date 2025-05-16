extends Node2D

@onready var name_box = $Customization_screen/ColorRect/Name/TextEdit
var player_name = ""

func _on_text_edit_text_changed() -> void:
	player_name = name_box.text

func _on_save_buttom_pressed() -> void:
	Global.player_name = player_name
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_random_button_pressed() -> void:
	var paths = [
		"Body",
		"Hair",
		"Shirts",
		"Pants",
		"Shoes",
		"Acc",
		"Eyes",
	]

	var character = $".".get_node("Character")
	for path in paths:
		var node = character.get_node_or_null(path)
		if node != null and node.has_method("randomize"):
			node.randomize()
