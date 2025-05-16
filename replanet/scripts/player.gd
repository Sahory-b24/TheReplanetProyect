extends CharacterBody2D

@onready var body = $Character/Body
@onready var hair = $Character/hair
@onready var shirts = $Character/shirts
@onready var pants = $Character/pants
@onready var shoes = $Character/shoes
@onready var eyes = $Character/eyes
@onready var accessory = $Character/acc
@onready var name_label = $Character/Name

@onready var animation_player = $AnimationPlayer

var last_direction = Vector2.ZERO
const speed = 100

func _ready():
	initialize_player()

func _physics_process(_delta):
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed )

	if direction.y != 0:
		velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed )

	if direction != Vector2.ZERO:
		last_direction = direction.normalized()

	var anim_to_play = ""

	if direction == Vector2.ZERO:
		if abs(last_direction.x) > abs(last_direction.y):
			anim_to_play = "idle_right" if last_direction.x < 0 else "idle_left"
		else:
			anim_to_play = "idle_back" if last_direction.y < 0 else "idle_front"
	else:
		if abs(direction.x) > abs(direction.y):
			anim_to_play = "walk_right" if direction.x < 0 else "walk_left"
		else:
			anim_to_play = "walk_back" if direction.y < 0 else "walk_front"

	if animation_player.current_animation != anim_to_play:
		animation_player.play(anim_to_play)

	move_and_slide()

func apply_recolor_shader(sprite: Sprite2D, texture: Texture2D, color: Color):
	sprite.texture = texture

	if sprite.material == null:
		var shader := preload("res://Shader/colors.gdshader") # Usa el shader corregido aquí
		var mat := ShaderMaterial.new()
		mat.shader = shader
		sprite.material = mat

	if sprite.material is ShaderMaterial:
		var mat := sprite.material as ShaderMaterial
		mat.set_shader_parameter("target_color", color)

func randomize_all():
	Global.selected_shirt = Global.shirts_options.keys().pick_random()
	Global.selected_pants = Global.pants_options.keys().pick_random()
	Global.selected_shoes = Global.shoes.keys().pick_random()
	Global.selected_hair = Global.hair_options.keys().pick_random()
	Global.selected_acc = Global.acc_options.keys().pick_random()

	Global.selected_shirt_color = Global.color_options.pick_random()
	Global.selected_pants_color = Global.color_options.pick_random()
	Global.selected_shoes_color = Global.color_options.pick_random()
	Global.selected_hair_color = Global.hair_color_options.pick_random()
	Global.selected_acc_color = Global.color_options.pick_random()



func initialize_player():
	if Global.selected_shirt == "":
		Global.selected_shirt = "1"
	if Global.selected_shirt_color == null:
		Global.selected_shirt_color = Global.color_options[0]

	if Global.selected_pants == "":
		Global.selected_pants = "1"
	if Global.selected_pants_color == null:
		Global.selected_pants_color = Global.color_options[0]

	# SkinColor
	body.texture = Global.body_options[Global.selected_body]

	# Hair con modulate
	hair.texture = Global.hair_options[Global.selected_hair]
	hair.modulate = Global.selected_hair_color

	# Eyes con modulate
	eyes.modulate = Global.selected_eyes_color

	# Shirt y Pants con shader de recolor
	apply_recolor_shader(shirts, Global.shirts_options[Global.selected_shirt], Global.selected_shirt_color)
	apply_recolor_shader(pants, Global.pants_options[Global.selected_pants], Global.selected_pants_color)

	# Shoes con modulate
	shoes.modulate = Global.selected_shoes_color

	# Accessory con shader de recolor
	apply_recolor_shader(accessory, Global.acc_options[Global.selected_acc], Global.selected_acc_color)

	# Player name
	#name_label.text = Global.player_name
	print(Global.player_name)
