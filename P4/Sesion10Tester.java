package es.ual.ualbd;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JOptionPane;

public class Sesion10Tester {
	public static void main(String[] args) {
		//Crear objeto de BDMySQL
		BDMySQL bdMySQL = new BDMySQL();
		
		//Inicializar valores de conexi�n
		String host = "localhost";
		String bd = "sakila";
		String user = "root";
		String password = "";
		
		//Si la conexi�n se realiza con �xito mostrar el formulario de inicio 
		if (bdMySQL.conectarBD(host, bd, user, password)) {
			FormInicio formInicio = new FormInicio(bdMySQL);
			formInicio.setVisible(true);
		}
	}
}
