
/**
 *
 * @author mduarte
 */
public class Lista {

    Nodo PTR;
    Nodo FINAL;

    public Lista() {
    }

    public Lista(Nodo PTR) {
        this.PTR = PTR;
    }

    public Nodo crearNodo(String dato) {
        Nodo nuevo = new Nodo(dato);
        return nuevo;
    }

    public void agregarNodoPorCola(String dato) {
        Nodo nuevo = crearNodo(dato);
        if (PTR == null) {
            PTR = nuevo;
            FINAL = PTR;
        } else {
            FINAL.sig = nuevo;
            FINAL = nuevo;
        }
    }

    public void imprimirLista(Nodo PTR) {
        Nodo A = PTR;
        while (A != null) {
            System.out.println(A.getDato());
            A=A.sig;
        }
    }

    public Nodo getPTR() {
        return PTR;
    }

    public void setPTR(Nodo PTR) {
        this.PTR = PTR;
    }
    
    
}
