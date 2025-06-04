extends Node

# Rutas de archivos JSON
var ruta_cola = "res://ArchivosDatos/puntajes_Nivel1_Cola.json"
var ruta_pila = "res://ArchivosDatos/puntajes_Nivel3_Pila.json"
var ruta_nivel2 = "res://ArchivosDatos/puntajes_Nivel2.json" # NUEVA RUTA

# NIVEL 1 (COLA: primero en entrar, primero en salir)
func guardar_puntaje_nivel1(nombre: String, puntaje: int) -> void:
	var puntajes = cargar_puntajes_nivel1()
	puntajes.append({ "nombre": nombre, "puntaje": puntaje })  # Al final
	guardar_json(ruta_cola, puntajes)

func cargar_puntajes_nivel1() -> Array:
	return cargar_json(ruta_cola)

# NIVEL 2 (COLA: primero en entrar, primero en salir)
func guardar_puntaje_nivel2(nombre: String, puntaje: int) -> void:
	var puntajes = cargar_puntajes_nivel2()
	puntajes.append({ "nombre": nombre, "puntaje": puntaje })  # Al final
	guardar_json(ruta_nivel2, puntajes)

func cargar_puntajes_nivel2() -> Array:
	return cargar_json(ruta_nivel2)

# NIVEL 3 (PILA: último en entrar, primero en salir) 
func guardar_puntaje_nivel3(nombre: String, puntaje: int) -> void:
	var puntajes = cargar_puntajes_nivel3()
	puntajes.insert(0, { "nombre": nombre, "puntaje": puntaje })  # Al inicio
	guardar_json(ruta_pila, puntajes)

func cargar_puntajes_nivel3() -> Array:
	return cargar_json(ruta_pila)

# FUNCIONES COMUNES DE ARCHIVO JSON 
func guardar_json(ruta: String, datos: Array) -> void:
	var file = FileAccess.open(ruta, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(datos, "\t"))
		file.close()

func cargar_json(ruta: String) -> Array:
	if FileAccess.file_exists(ruta):
		var file = FileAccess.open(ruta, FileAccess.READ)
		var contenido = file.get_as_text()
		file.close()
		var json = JSON.parse_string(contenido)
		if json is Array:
			return json
	return []
