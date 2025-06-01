extends CanvasLayer

@onready var filter = $ColorBlindFilter
@onready var mat = filter.material

func set_mode(mode: int):
	mat.set_shader_parameter("mode", mode)
	filter.visible = mode != 0

#func _ready():
#	set_mode(1)  # Forzar filtro activado para probar
