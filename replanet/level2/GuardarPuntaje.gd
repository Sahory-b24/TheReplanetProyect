extends Node

var ruta = "user://puntajes.txt"

func guardar_puntaje(nombre: String, puntaje: int) -> void:
	var file := FileAccess.open(ruta, FileAccess.READ_WRITE)
	if file:
		file.seek_end() 
		file.store_line("%s: %d" % [nombre, puntaje])
		file.close()

func cargar_puntajes() -> Array:
	var puntajes = []
	if FileAccess.file_exists(ruta):
		var file = FileAccess.open(ruta, FileAccess.READ)
		while not file.eof_reached():
			var linea = file.get_line()
			if linea != "":
				puntajes.append(linea)
		file.close()
	else:
		print("no estan cargando lso archivos")
	return puntajes
