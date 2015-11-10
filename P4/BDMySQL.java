package es.ual.ualbd;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import javax.swing.plaf.basic.BasicInternalFrameTitlePane.MaximizeAction;

public class BDMySQL {
	private Connection conexion;
	private Statement sentencia;

	private boolean registrarDriver() {
		try {
			Class.forName("com.mysql.jdbc.Driver");

			return (true);
		} catch (ClassNotFoundException e) {
			System.out.println("Driver no encontrado");
			e.printStackTrace();
			return (false);
		}
	}

	public boolean conectarBD(String host, String bd, String login, String password) {
		if (registrarDriver()) {
			try {
				String urlBD;
				host = "jdbc:mysql://";
				bd = "localhost/sesion10";
				login = "root";
				password = "";
				urlBD = host + bd+"," +login + ","+password;
				//URL de la base de datos
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Inicializar urlBD con la URL de la base de datos
				********/				
				Connection conexion = DriverManager.getConnection(urlBD);
				// Obtener la conexi�n a la BD
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Inicializar la conexion con la URL, login y password
				********/

				Statement sentencia = conexion.createStatement();
				//Crear el objeto sentencia
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Crear la sentencia para que permita desplazamiento y actualizaciones directas
				********/
				
				return true;
			} catch (SQLException e) {
				System.out.println("Error SQL");
				e.printStackTrace();
				return false;
			}
		} else {
			return false;
		}
	}

	public int ejecutarDML(String cadenaSQL) {
		try {
			int filasAfectadas;
			
			cadenaSQL = "";
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Ejecutar el SQL pasado como par�metro y devolver el n�mero de filas afectadas por la operaci�n
			********/
			filasAfectadas = sentencia.executeUpdate(cadenaSQL);
			return filasAfectadas;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			//Devolver 1 en caso de error
			return -1;
		}
	}

	public int insertarPersona(String nombre, String apellidos, String profesion) {
		String cadenaSQL;
		
		/****** 
		*** TU CODIGO AQUI *** 
		* 1. Inicializar cadenaSQL con un script SQL de inserci�n parametrizada para una PreparedStatement
		********/
		cadenaSQL = "INSERT INTO Personal" + "(nombre, apellidos, profesion) VALUES (?,?,?)";

		//Crear el objeto sentencia
		PreparedStatement sentenciaPreparada;
		try {
			//Preparar la sentencia y asignarle los par�metros
			sentenciaPreparada = conexion.prepareStatement(cadenaSQL);

			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Crear la sentencia preparada con la cadena definida en el paso anterior
			* 2. Asignarle a la sentencia preparada los tres par�metros del m�todo
			********/
			sentenciaPreparada.setString(1, nombre);
			sentenciaPreparada.setString(2, apellidos);
			sentenciaPreparada.setString(3, profesion);
			sentenciaPreparada.executeUpdate();

			//Ejecutar la consulta
			int filasAfectadas;
			filasAfectadas = sentenciaPreparada.executeUpdate(cadenaSQL);
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Ejecutar la consulta y devolver el n�mero de filas afectadas
			********/			
			
			return filasAfectadas;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			// Devolver -1 en caso de error
			return -1;
		}
	}

	public String obtenerProfesion(String nombre, String apellidos) {
		String cadenaSQL;
		cadenaSQL = "SELECT profesion FROM Personal WHERE nombre =" +nombre +"AND apellidos = "+apellidos;
		/****** 
		*** TU CODIGO AQUI *** 
		* 1. Definir el SQL que obtiene la profesi�n a partir de los par�metros del m�todo 
		********/

		try {
			//Ejecutar la consulta
			ResultSet resultado;
			resultado = sentencia.executeQuery(cadenaSQL);
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Asignar a "resultado" la ejecuci�n de la consulta
			********/

			if (resultado != null) {
				resultado.next();
				return resultado.getString("profesion");
			}
			else return null;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
}

	public ResultSet obtenerRegistros (String tabla)  {
		//Crear SELECT para la tabla par�metro
		String cadenaSQL = "SELECT * FROM " + tabla;

		ResultSet resultado;
		
		try {
			resultado = sentencia.executeQuery(cadenaSQL);
			//Devolver el resultado del SELECT
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Asignar a "resultado" la ejecuci�n de la consulta
			********/
			
			return resultado;
		} catch (SQLException e) {
			//Devolver null e informar del error
			e.printStackTrace();
			return null;
		}
	}

	public void obtenerPersonas(){
		//Obtener todas las personas
		ResultSet resultado = obtenerRegistros("Personal");
		try {
			while(resultado.next()){
				System.out.println(resultado.getString(1)+ " "+ resultado.getString(2) + " " + resultado.getString(3));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/****** 
		*** TU CODIGO AQUI *** 
		* 1. Mostrar por la consola todo el contenido de "resultado" 
		********/
		//Recorrer el ResultSet y mostrar todas las columnas de todos los registros

	}
	
	public ResultSet obtenerResultSetTabla(String tabla) {
		//Crear SELECT para la tabla par�metro
		String cadenaSQL = "SELECT * FROM " + tabla;

		try {
			//Devolver el resultado del SELECT
			ResultSet resultado = sentencia.executeQuery(cadenaSQL);
			resultado.next();
			return resultado;
		} catch (SQLException e) {
			//Devolver null e informar del error
			e.printStackTrace();
			return null;
		}
		
	}

	public void desconectarBD() {
		try {
			sentencia.close();
			conexion.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void modificarPersonasPorResultSet() {
		try {
			ResultSet resultado;
			String cadenaSQL = "SELECT * FROM Personal";
			resultado = sentencia.executeQuery(cadenaSQL);

			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Volcar en "resultado" la tabla Personal
			********/
			resultado.next();
			resultado.next();
			resultado.next();
			resultado.next();
			resultado.next();
			resultado.updateString("profesion", "Ingeniero Informatico");
			resultado.updateRow();
			resultado.previous();
			resultado.updateString("profesion", "Ingeniero Informatico");
			resultado.updateRow();
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Ir al quinto registro
			* 2. Sustituir la profesi�n por Ingeniero Inform�tico
			* 3. Actualizar el ResultSet
			* 4. Ir al registro anterior
			* 5. Sustituir la profesi�n por Ingeniero Inform�tico
			* 6. Actualizar el ResultSet
			********/
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}

	public ResultSet moverAlRegistroSiguiente(ResultSet resultado) {
		try {
			resultado.next();
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Ir al registro siguiente
			********/

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}

	public ResultSet moverAlRegistroAnterior(ResultSet resultado) {
		try {
			resultado.previous();
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Ir al registro anterior
			********/
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}

	public ResultSet moverAlPrimerRegistro(ResultSet resultado) {
		try {
			resultado.first();
			/******

			*** TU CODIGO AQUI *** 
			* 1. Ir al primer registro
			********/
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}

	public ResultSet moverAlUltimoRegistro(ResultSet resultado) {
		try {	
			resultado.last();
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Ir al �limo registro
			********/
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultado;
	}

	public HashMap<String, String> obtenerPersonaActual(ResultSet resultado) {
		HashMap<String, String> personaActual = new HashMap<String, String>();
		
		try {
			String nombre = resultado.getString("nombre");
			String apellidos = resultado.getString("apellidos");
			String profesion = resultado.getString("profesion");
			personaActual.put(nombre, nombre);
			personaActual.put(apellidos, apellidos);
			personaActual.put(profesion, profesion);
			
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Volcar en el mapa con claves (nombre, apellidos, profesion) los valores correspondientes del ResultSet
			********/
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return personaActual;
	}

	public void inicializarBD() {
		ejecutarDML("INSERT INTO Personal(nombre, apellidos, profesion) " +
				"VALUES ('Pepe', 'Ramirez', 'Taxista')");
		insertarPersona("Juan", "Castro", "Electricista");
		insertarPersona("Luisa", "Heredia", "Pintor");
		insertarPersona("Luis", "Molina", "Enfermero");
		insertarPersona("Antonio", "Zurita", "Fontanero");
		insertarPersona("Miguel", "Orozco", "Ingeniero Informatico");
		insertarPersona("Ana", "Amate", "Abogada");
		insertarPersona("Catalina", "Bonillo", "Psicologa");
		insertarPersona("Mario", "Restoy", "Veterinario");
		insertarPersona("Alfredo", "Sorolla", "Pintor");
	}

	public void modificarPersona(String nombre, String apellidos, String profesion,
			ResultSet resultado) {
		try {
			resultado.last();
			resultado.updateString("nombre", nombre);
			resultado.updateString("apellidos", apellidos);
			resultado.updateString("profesion", profesion);
			resultado.updateRow();
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Actualizar el ResultSet con los datos proporcionados como par�metro
			********/
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ResultSet eliminarPersona(ResultSet resultado) {
		try {
			/****** 
			*** TU CODIGO AQUI *** 
			* 1. Eliminar el registro actual del ResultSet
			********/
			resultado.deleteRow();
			return resultado;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
