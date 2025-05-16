// Class Megaferia
public Autor obtenerAutorMaxEditoriales() {
    ArrayList<Autor> autores = new ArrayList<>();
    for (Editorial editorial : this.editoriales) {
        ArrayList<Autor> autoresEditorial = editorial.obtenerAutores();
        for (Autor autor : autoresEditorial) {
            if (!autores.contains(autor)) {
                autores.add(autor);
            }
        }
    }
    Autor autorMaxEditoriales = autores.get(0);
    for (Autor autor : autores) {
        if (autor.obtenerNumEditoriales() > autorMaxEditoriales.obtenerNumEditoriales()) {
            autorMaxEditoriales = autor;
        }
    }
    return autorMaxEditoriales;
}

// Class Editorial
public ArrayList<Autor> obtenerAutores() {
    ArrayList<Autor> autores = new ArrayList<>();
    for (Libro libro : this.libros) {
        ArrayList<Autor> autoresLibro = libro.getAutores();
        for (Autor autor : autoresLibro) {
            if (!autores.contains(autor)) {
                autores.add(autor);
            }
        }
    }
    return autores;
}

// Class Autor
public int obtenerNumEditoriales() {
    ArrayList<Editorial> editoriales = new ArrayList<>();
    for (Libro libro : this.libros) {
        if (!editoriales.contains(libro.getEditorial())) {
            editoriales.add(libro.getEditorial())
        }
    }
    return editoriales.size();
}