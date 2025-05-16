/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author mduarte
 */
public class Main {
    public static void main(String[] args) {
        Lista lista1 = new Lista();
        Lista lista2 = new Lista();
        ManejoLista ml = new ManejoLista();
        
        lista1.agregarNodoPorCola("A");
        lista1.agregarNodoPorCola("B");
        lista1.agregarNodoPorCola("C");
        
        lista2.agregarNodoPorCola("A");
        lista2.agregarNodoPorCola("E");
        lista2.agregarNodoPorCola("C");
        ml.crearInterseccion(lista1, lista2);
    }
}
