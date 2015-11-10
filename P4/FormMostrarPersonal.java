package es.ual.ualbd;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JTextField;
import javax.swing.JLabel;
import javax.swing.JButton;

import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class FormMostrarPersonal extends JFrame {

	private JPanel contentPane;
	private JTextField txtNombre;
	private JTextField txtApellidos;
	private JTextField txtProfesion;
	private ResultSet resultado;

	/**
	 * Create the frame.
	 */
	public FormMostrarPersonal(final BDMySQL bdMySQL) {
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		txtNombre = new JTextField();
		txtNombre.setToolTipText("Nombre");
		txtNombre.setBounds(116, 36, 315, 28);
		contentPane.add(txtNombre);
		txtNombre.setColumns(10);
		
		txtApellidos = new JTextField();
		txtApellidos.setToolTipText("Apellidos");
		txtApellidos.setBounds(116, 76, 315, 28);
		contentPane.add(txtApellidos);
		txtApellidos.setColumns(10);
		
		txtProfesion = new JTextField();
		txtProfesion.setToolTipText("Profesion");
		txtProfesion.setBounds(116, 116, 315, 28);
		contentPane.add(txtProfesion);
		txtProfesion.setColumns(10);
		
		JLabel lblNombre = new JLabel("Nombre:");
		lblNombre.setBounds(28, 42, 76, 16);
		contentPane.add(lblNombre);
		
		JLabel lblApellidos = new JLabel("Apellidos:");
		lblApellidos.setBounds(28, 82, 76, 16);
		contentPane.add(lblApellidos);
		
		JLabel lblProfesion = new JLabel("Profesion:");
		lblProfesion.setBounds(28, 122, 76, 16);
		contentPane.add(lblProfesion);
		
		inicializarTextBoxes(bdMySQL);
		
		JButton btnPrimero = new JButton("|<");
		btnPrimero.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				bdMySQL.moverAlPrimerRegistro(resultado);
				try {
					escribirEnTextBoxes(resultado.getString("nombre"), resultado.getString("apellidos"), resultado.getString("profesion"));
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Mover el ResultSet al primer registro con el m�todo bdMySQL.moverAlPrimerRegistro()
				* 2. Actualizar los text boxes con el m�todo escribirEnTextBoxes()
				********/	
			}
		});
		btnPrimero.setBounds(100, 198, 60, 29);
		contentPane.add(btnPrimero);
		
		JButton btnAnterior = new JButton("<<");
		btnAnterior.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				bdMySQL.moverAlRegistroAnterior(resultado);
				try {
					escribirEnTextBoxes(resultado.getString("nombre"), resultado.getString("apellidos"), resultado.getString("profesion"));
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Mover el ResultSet al registro anterior con el m�todo bdMySQL.moverAlRegistroAnterior()
				* 2. Actualizar los text boxes con el m�todo escribirEnTextBoxes()
				********/						
			}
		});
		btnAnterior.setBounds(172, 198, 60, 29);
		contentPane.add(btnAnterior);
		
		JButton btnSiguiente = new JButton(">>");
		btnSiguiente.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				bdMySQL.moverAlRegistroSiguiente(resultado);
				try {
					escribirEnTextBoxes(resultado.getString("nombre"), resultado.getString("apellidos"), resultado.getString("profesion"));
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Mover el ResultSet al registro anterior con el m�todo bdMySQL.moverAlRegistroSiguiente()
				* 2. Actualizar los text boxes con el m�todo escribirEnTextBoxes()
				********/				
			}
		});
		btnSiguiente.setBounds(244, 198, 60, 29);
		contentPane.add(btnSiguiente);
		
		JButton button = new JButton(">|");
		button.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				bdMySQL.moverAlUltimoRegistro(resultado);
				try {
					escribirEnTextBoxes(resultado.getString("nombre"), resultado.getString("apellidos"), resultado.getString("profesion"));
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Mover el ResultSet al registro anterior con el m�todo bdMySQL.moverAlUltimoRegistro()
				* 2. Actualizar los text boxes con el m�todo escribirEnTextBoxes()
				********/				
			}
		});
		button.setBounds(316, 198, 60, 29);
		contentPane.add(button);
		
		JButton btnModificar = new JButton("Modificar");
		btnModificar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				String nombre = "Juan";
				String apellidos= "Garcia";
				String profesion= "Jardinero";
				bdMySQL.modificarPersona(nombre, apellidos, profesion, resultado);
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Actualizar el ResultSet mediante el m�todo bdMySQL.modificarPersona()
				********/
			}
		});
		btnModificar.setBounds(100, 157, 117, 29);
		contentPane.add(btnModificar);
		
		JButton btnEliminar = new JButton("Eliminar");
		btnEliminar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				bdMySQL.eliminarPersona(resultado);
				escribirEnTextBoxes("","","");
				/****** 
				*** TU CODIGO AQUI *** 
				* 1. Eliminar del ResultSet el registro actual mediante el m�todo bdMySQL.eliminarPersona()
				* 2. Usar escribirEnTextBoxes() para borrar los text boxes
				********/
			}
		});
		btnEliminar.setBounds(259, 157, 117, 29);
		contentPane.add(btnEliminar);
	}

	private void inicializarTextBoxes(BDMySQL bdMySQL) {
		//Volcar la tabla Personal como ResultSet en "resultado"
		resultado = bdMySQL.obtenerResultSetTabla("Personal");
		bdMySQL.obtenerPersonaActual(resultado);
		try {
			escribirEnTextBoxes(resultado.getString("nombre"), resultado.getString("apellidos"), resultado.getString("profesion"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/****** 
		*** TU CODIGO AQUI *** 
		* 1. Usar bdMySQL.obtenerPersonaActual() para obtener como un HashMap la persona actual del ResultSet
		* 2. Usar escribirEnTextBoxes() para mostrar los datos de la persona en los text boxes
		********/
	}

	private void escribirEnTextBoxes(HashMap<String, String> persona) {
		try {
			escribirEnTextBoxes(resultado.getString("nombre"), resultado.getString("apellidos"), resultado.getString("profesion"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/****** 
		*** TU CODIGO AQUI *** 
		* 1. Usar escribirEnTextBoxes() para escribir el contenido del HashMap
		********/
	}

	private void escribirEnTextBoxes(String nombre, String apellidos, String profesion) {
		txtNombre.setText(nombre);
		txtApellidos.setText(apellidos);
		txtProfesion.setText(profesion);	
	}
}
