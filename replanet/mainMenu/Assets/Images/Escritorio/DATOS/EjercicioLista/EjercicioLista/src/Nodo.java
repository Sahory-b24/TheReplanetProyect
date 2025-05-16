/**
 *
 * @author mduarte
 */
public class Nodo {
    String dato;
    Nodo sig;

    public Nodo(String dato) {
        this.dato = dato;
    }

    public Nodo() {
    }

    public String getDato() {
        return dato;
    }

    public void setDato(String dato) {
        this.dato = dato;
    }

    public Nodo getSig() {
        return sig;
    }

    public void setSig(Nodo sig) {
        this.sig = sig;
    }
    
    
}
