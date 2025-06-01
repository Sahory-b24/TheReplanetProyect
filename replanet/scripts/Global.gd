extends Node

var modo_juego: String = "RPG"

#Collection Body Options (Opciones de Skin Color) 
var body_options ={
	"1" = preload("res://assests/Sprite/walk/char1_walk.png"),
	"2" = preload("res://assests/Sprite/walk/char2_walk.png"),
	"3" = preload("res://assests/Sprite/walk/char3_walk.png"),
	"4" = preload("res://assests/Sprite/walk/char4_walk.png"),
	"5" = preload("res://assests/Sprite/walk/char5_walk.png"),
	"6" = preload("res://assests/Sprite/walk/char6_walk.png"),
	"7" = preload("res://assests/Sprite/walk/char7_walk.png"),
	"8" = preload("res://assests/Sprite/walk/char8_walk.png")
}
#Collection hair options
var hair_options ={
	"none" = null,
	"1" = preload("res://assests/Sprite/walk/hair/bobBrown_walk.png"),
	"2" = preload("res://assests/Sprite/walk/hair/braidsBrown_walk.png"),
	"3" = preload("res://assests/Sprite/walk/hair/buzzcutBrown_walk.png"),
	"4" = preload("res://assests/Sprite/walk/hair/curlyBrown_walk.png"),
	"5" = preload("res://assests/Sprite/walk/hair/emoBrown_walk.png"),
	"7" = preload("res://assests/Sprite/walk/hair/extra_longBrown_walk.png"),
	"8" = preload("res://assests/Sprite/walk/hair/french_curlBrown_walk.png"),
	"9" = preload("res://assests/Sprite/walk/hair/gentlemanBrown_walk.png"),
	"10" = preload("res://assests/Sprite/walk/hair/long_straightBrown_walk.png"),
	"11" = preload("res://assests/Sprite/walk/hair/ponytailBlack_walk.png"),
	"12" = preload("res://assests/Sprite/walk/hair/spacebunsBrown_walk.png"),
	"13" = preload("res://assests/Sprite/walk/hair/wavyBrown_walk.png")
	
}
#Collection shirts options
var shirts_options ={
	"1" = preload("res://assests/Sprite/walk/clothes/basicWhite_walk.png"),
	"2" = preload("res://assests/Sprite/walk/clothes/dressWhite_walk.png"),
	"3" = preload("res://assests/Sprite/walk/clothes/floralWhite_walk.png"),
	"4" = preload("res://assests/Sprite/walk/clothes/overall_walk.png"),
	"5" = preload("res://assests/Sprite/walk/clothes/sailor1_walk.png"),
	"6" = preload("res://assests/Sprite/walk/clothes/sailor_bow1_walk.png"),
	"7" = preload("res://assests/Sprite/walk/clothes/skull_walk.png"),
	"8" = preload("res://assests/Sprite/walk/clothes/spaghetti_walk.png"),
	"9" = preload("res://assests/Sprite/walk/clothes/sporty_walk.png"),
	"10" = preload("res://assests/Sprite/walk/clothes/stripe_walk.png"),
	"11" = preload("res://assests/Sprite/walk/clothes/suit_walk.png")

}
#Collection pants options
var pants_options ={
	"1" = preload("res://assests/Sprite/walk/clothes/pantsWhite_walk.png"),
	"2" = preload("res://assests/Sprite/walk/clothes/skirtGrey_walk.png"),
	"3" = preload("res://assests/Sprite/walk/clothes/pants1_suit_walk.png"),
	"4" = preload("res://assests/Sprite/walk/clothes/witch_walk.png"),
	"5" = preload("res://assests/Sprite/walk/clothes/clownGrey_walk.png")

	
}
#Collection shoes options
var shoes ={
	"1" = preload("res://assests/Sprite/walk/clothes/shoes1_walk.png")
}
#Collection eyes options
var eyes ={
	"1" = preload("res://assests/Sprite/walk/eyes/eyesBrown_walk.png")
}
#Collection lips options
var lips ={
	"1" = preload("res://assests/Sprite/walk/eyes/lipstick1_walk.png")
}
#Collection blush options
var blush ={
	"none" = null,
	"1" = preload("res://assests/Sprite/walk/eyes/blush1_walk.png")
}
#Collection acc options
var acc_options ={
	"none" = null,
	"1"= preload("res://assests/Sprite/walk/acc/glasses1_walk.png"),
	"2" = preload("res://assests/Sprite/walk/acc/glassesBlack_sun_walk.png"),
	"3" = preload("res://assests/Sprite/walk/acc/beardBrown_walk.png"),
	"4" = preload("res://assests/Sprite/walk/acc/earring_emerald_walk.png"),
	"5" = preload("res://assests/Sprite/walk/acc/earring_red_silver_walk.png"),
	"6" = preload("res://assests/Sprite/walk/acc/hatGrey_cowboy_walk.png"),
	"7" = preload("res://assests/Sprite/walk/acc/hat_lucky_walk.png"),
	"8" = preload("res://assests/Sprite/walk/acc/hat_pumpkin_walk.png"),
	"9" = preload("res://assests/Sprite/walk/acc/hatGrey_witch_walk.png"),
}
# Hair colors
var hair_color_options = [
	Color(1, 1, 1), # Default
	Color (0.3, 0.3, 0.3)  , # Black
	Color(0.4, 0.2, 0.1), # Brown
	Color(0.9, 0.6, 0.2), # Blonde
	Color(0.95, 0.8, 0.3), #Extra Blonde  
	Color(0.5, 0.25, 0), # Auburn
	Color(1, 0, 0), # Red
	Color(0.7, 0.7, 0.7) #Gey
]

# Outfit & accessory colors
var color_options = [
	Color(1, 1, 1), # Default
	Color(1, 0, 0), # Red
	Color(0, 1, 0), # Green
	Color(0, 0, 1), # Blue
	Color(0, 0, 0), # Black
	Color(1, 1, 1), # White
]

# Selected values
var selected_body = ""
var selected_hair = ""
var selected_shirt = ""
var selected_pants = ""
var selected_shoes = ""
var selected_eyes = ""
var selected_lips = ""
var selected_blush = ""
var selected_acc = ""

var selected_hair_color = null
var selected_shirt_color = null
var selected_pants_color = null
var selected_shoes_color = null
var selected_eyes_color = null
var selected_lips_color = null
var selected_blush_color = null
var selected_acc_color = null

var player_name = ""
