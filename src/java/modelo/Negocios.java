/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import datos.Conexion;
import java.util.ArrayList;
import java.util.Vector;

/**
 *
 * @author RMUNAYCO
 */
public class Negocios {
Conexion xcon;

    public Negocios() {
        xcon= new Conexion();
    }

    public ArrayList buscar_deudas(String ruc) {
        ArrayList valores= new ArrayList();
        String nombre= xcon.buscar_nombre(ruc);
        valores.add(nombre);
        if(!nombre.equals("x")){
           Vector tdeudas= xcon.datos_deudas(ruc);
           if(tdeudas.size() < 1){
               nombre="z";
               valores.set(0, nombre);
           }else{
           valores.add(tdeudas);
           }
        }
        return valores;
   }
    
    
    
}
