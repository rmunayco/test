

package datos;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.TreeSet;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author RMUNAYCO
 */
public class Conexion {
Connection mibase;
Statement operacion;
ResultSet resultado;
PreparedStatement comando;
    public Conexion() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Driver JDBC instalado");
            mibase= DriverManager.
                    getConnection("jdbc:mysql://localhost:3306/deudas",
                    "root","root");
            System.out.println("BD Deudas conectada");
        } catch (Exception ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }



    public String buscar_nombre(String ruc) {
       String xnombre="x";
         String sentencia= "select apellidos,nombres from contribuyente WHERE nruc='"+ruc+"'";
        try {
            operacion = mibase.createStatement();
            resultado= operacion.executeQuery(sentencia);
             if(resultado.next()){
                xnombre= resultado.getString(1)+" "+resultado.getString(2);
             }
            resultado.close();
            operacion.close();
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
       
       return xnombre;
    }

    public Vector datos_deudas(String ruc) {
        Vector varios= new Vector();
         String sentencia= "select p.nruc,q.descripcion,p.periodo,p.resolucion,p.codigo,p.monto from deudas p,parametro q WHERE p.criterio= q.parametro " +
         "and q.tabla=2 and nruc='"+ruc+"'";
        try {
            operacion = mibase.createStatement();
            resultado= operacion.executeQuery(sentencia);
             while(resultado.next()){
                String[] fila= new String[6];
                 fila[0]=resultado.getString(1);
                 fila[1]=resultado.getString(2);
                 fila[2]=resultado.getString(3);
                 fila[3]=resultado.getString(4);
                 fila[4]=resultado.getString(5);
                 fila[5]=String.valueOf(resultado.getDouble(6));
                 varios.add(fila);
             }
            resultado.close();
            operacion.close();
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
        return varios;
    }

}
