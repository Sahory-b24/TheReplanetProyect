
/**
 *
 * @author mduarte
 */
public class ManejoLista {

    public void crearInterseccion(Lista PTR1, Lista PTR2) {
        Lista lista = new Lista();

        Nodo p = PTR1.getPTR();
        while (p != null) {
            Nodo q = PTR2.getPTR();
            while (q != null) {
                if (p.getDato().equals(q.getDato())) {
                    lista.agregarNodoPorCola(p.getDato());
                }
                q = q.sig;
            }
            p = p.sig;
        }
        lista.imprimirLista(lista.getPTR());
    }
}
