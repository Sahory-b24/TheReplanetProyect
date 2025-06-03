extends Control

signal minijuego_completado(lever_id: int, puntos: int)

@export var lever_id: int = 0 # <- Esto permite recibir el id de la palanca
var cantidad_cables = 4
var colores_disponibles = ["Rojo", "Verde", "Amarillo", "Azul"]

var cables_correctos = 0
var puntos = 0
var conexiones = {}
var conector_seleccionado: TextureRect = null
var lado_origen: String = ""

@onready var textura_rojo = preload("res://level3/Assets/textures/redWire_left.tres")
@onready var textura_verde = preload("res://level3/Assets/textures/greenWire_left.tres")
@onready var textura_azul = preload("res://level3/Assets/textures/blueWire_left.tres")
@onready var textura_amarillo = preload("res://level3/Assets/textures/yellowWire_left.tres")

var texturas_por_color_y_lado
var texturas_linea_por_color 
@onready var timer = $MinijuegoCables/Timer
@onready var label_tiempo = $MinijuegoCables/TiempoLabel
@onready var label_puntaje = $MinijuegoCables/PuntajeLabel
@onready var panel_fin = $MinijuegoCables/PanelFin
@onready var contenedor_entradas = $MinijuegoCables/ConectoresIzquierda
@onready var contenedor_salidas = $MinijuegoCables/ConectoresDerecha
@onready var label_progreso = $MinijuegoCables/ConexionesLabel
@onready var line_drawer = $MinijuegoCables/LineDrawer
@onready var indicador_color = $MinijuegoCables/Panel2/indicadorColor

var errores_previos: Dictionary = {}
var conexiones_realizadas: Dictionary = {}


func _ready():
	lever_id = GameState.current_lever_id
	texturas_por_color_y_lado = {
		"Rojo": {
		"izquierda": preload("res://level3/Assets/textures/redWire_left.tres"),
		"derecha": preload("res://level3/Assets/textures/redWire_right.tres")
	},
	"Verde": {
		"izquierda": preload("res://level3/Assets/textures/greenWire_left.tres"),
		"derecha": preload("res://level3/Assets/textures/greenWire_right.tres")
	},
	"Azul": {
		"izquierda": preload("res://level3/Assets/textures/blueWire_left.tres"),
		"derecha": preload("res://level3/Assets/textures/blueWire_right.tres")
	},
	"Amarillo": {
		"izquierda": preload("res://level3/Assets/textures/yellowWire_left.tres"),
		"derecha": preload("res://level3/Assets/textures/yellowWire_right.tres")
	}
	}
	texturas_linea_por_color = {
	"Rojo": preload("res://level3/Assets/textures/redLine.tres"),
	"Verde": preload("res://level3/Assets/textures/greenLine.tres"),
	"Azul": preload("res://level3/Assets/textures/blueLine.tres"),
	"Amarillo": preload("res://level3/Assets/textures/yellowLine.tres")
	}

	generar_conectores(cantidad_cables)
	timer.start(20.0)
	label_puntaje.text = "Puntaje: 0"
	panel_fin.visible = false
	label_progreso.text = "0 / " + str(cantidad_cables)
	indicador_color.color = Color(0, 0, 0, 0)
	


func generar_conectores(cantidad):
	var colores = colores_disponibles.duplicate()
	colores.shuffle()
	var colores_entrada = colores.slice(0, cantidad)
	var colores_salida = colores_entrada.duplicate()
	colores_salida.shuffle()

	for i in range(cantidad):
		var color_entrada = colores_entrada[i]
		var color_salida = colores_salida[i]
		crear_conector(color_entrada, contenedor_entradas, "izquierda")
		crear_conector(color_salida, contenedor_salidas, "derecha")


func crear_conector(color_name: String, padre: Container, lado: String):
	var conector = TextureRect.new()
	conector.texture = texturas_por_color_y_lado[color_name][lado]
	conector.name = color_name
	conector.expand = true
	conector.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	conector.custom_minimum_size = Vector2(48, 48)
	conector.mouse_filter = Control.MOUSE_FILTER_PASS
	conector.set_focus_mode(FOCUS_NONE)
	conector.gui_input.connect(_on_conector_input.bind(conector, lado))
	padre.add_child(conector)

func obtener_color(nombre: String) -> Color:
	match nombre:
		"Rojo": return Color(1, 0, 0)
		"Verde": return Color(0, 1, 0)
		"Azul": return Color(0, 0.4, 1)
		"Amarillo": return Color(1, 1, 0)
		_: return Color(1, 1, 1)

func _on_conector_input(event: InputEvent, conector: TextureRect, lado: String):
	if event is InputEventMouseButton and event.pressed:
		if conector_seleccionado == null:
			conector_seleccionado = conector
			lado_origen = lado
			indicador_color.color = obtener_color(conector.name)
		elif conector != conector_seleccionado and lado != lado_origen:
			conectar_cable(conector_seleccionado, conector)

			# Solo bloquear click y dibujar línea si fue correcta
			if conector.name == conector_seleccionado.name:
				conector_seleccionado.mouse_filter = Control.MOUSE_FILTER_IGNORE
				conector.mouse_filter = Control.MOUSE_FILTER_IGNORE
				dibujar_linea(conector_seleccionado, conector)

			# Reiniciar selección
			conector_seleccionado = null
			lado_origen = ""
			indicador_color.color = Color(0, 0, 0, 0)



func conectar_cable(entrada: TextureRect, salida: TextureRect):
	var id = entrada.name
	# Ya se conectó correctamente antes, no hacer nada
	if conexiones_realizadas.has(id):
		return
	# Es correcta la conexión
	if entrada.name == salida.name:
		if errores_previos.get(id, false):
			# Reconexión correcta tras error: +30
			puntos += 30
		else:
			# Primera conexión correcta: +150
			puntos += 150
		conexiones_realizadas[id] = true
		cables_correctos += 1
	else:
		# Conexión incorrecta
		if errores_previos.has(id):
			# Ya había fallado antes: penalización adicional
			puntos -= 10
		else:
			# Primer error
			puntos -= 50
		errores_previos[id] = true

	# Actualizar UI
	label_puntaje.text = "Puntaje: " + str(puntos)
	label_progreso.text = str(cables_correctos) + " / " + str(cantidad_cables)

	# Finalización
	if cables_correctos >= cantidad_cables:
		finalizar_minijuego()

		
func dibujar_linea(conector1: TextureRect, conector2: TextureRect):
	var linea = Line2D.new()
	linea.width = 8
	linea.texture_mode = Line2D.LINE_TEXTURE_TILE
	linea.texture = texturas_linea_por_color[conector1.name]

	var margen_horizontal = 6

	# Obtener posiciones y tamaños
	var pos1 = conector1.get_global_position()
	var size1 = conector1.size
	var pos2 = conector2.get_global_position()
	var size2 = conector2.size

	var punto_a: Vector2
	var punto_b: Vector2

	# Determinar el orden de entrada y salida según lado_origen
	if lado_origen == "izquierda":
		punto_a = pos1 + Vector2(size1.x - margen_horizontal - 10, size1.y / 2) # desde la derecha
		punto_b = pos2 + Vector2(margen_horizontal + 10, size2.y / 2)           # hacia la izquierda
	else:
		punto_a = pos2 + Vector2(size2.x - margen_horizontal - 10, size2.y / 2) # desde la derecha
		punto_b = pos1 + Vector2(margen_horizontal + 10, size1.y / 2)           # hacia la izquierda

	# Convertir a coordenadas locales del contenedor de líneas
	punto_a = line_drawer.to_local(punto_a)
	punto_b = line_drawer.to_local(punto_b)

	linea.add_point(punto_a)
	linea.add_point(punto_b)
	line_drawer.add_child(linea)



func _on_Timer_timeout():
	finalizar_minijuego()

func finalizar_minijuego():
	timer.stop()
		# Bonus si todas las conexiones están bien y no hubo errores
	var todos_sin_errores = true
	for id in errores_previos.keys():
		if not conexiones_realizadas.has(id):
			todos_sin_errores = false
			break
	if todos_sin_errores and errores_previos.size() == 0:
		puntos += 100

	# Bonus por tiempo restante
	if timer.time_left > 0:
		puntos += 50

	label_puntaje.text = "Puntaje final: " + str(puntos)

	# Mensaje final
	var mensaje = ""
	if puntos >= 600:
		mensaje = "¡Excelente! Conexiones perfectas y a tiempo."
	elif puntos >= 400:
		mensaje = "¡Bien hecho! Pero podrías mejorar tu tiempo o evitar errores."
	else:
		mensaje = "Faltó precisión o rapidez. Intenta de nuevo."

	$MinijuegoCables/PanelFin/MensajeLabel.text = mensaje
	panel_fin.visible = true
	# ACTUALIZA LOS VALORES EN GameState AQUÍ
	GameState.palancas_activadas[lever_id] = true
	GameState.puntaje_palancas[lever_id] = puntos
	GameState.puntaje_total = 0
	for p in GameState.puntaje_palancas:
		GameState.puntaje_total += p
	emit_signal("minijuego_completado", lever_id, puntos)



func _process(delta):
	if timer.is_stopped():
		return
	label_tiempo.text = "Tiempo: " + str(round(timer.time_left)) + "s"


func _on_boton_salir_pressed() -> void:
	SceneTransitions.change_scene_to_file("res://level3/Scenes/level_3.tscn")

	pass # Replace with function body.
