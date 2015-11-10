package es.ual.ualbd;

import java.awt.BorderLayout;
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
import java.util.HashMap;

public class FormInsertarPersonal extends JFrame {

	private JPanel contentPane;
	private JTextField txtNombre;
	private JTextField txtApellidos;
	private JTextField txtProfesion;

	/**
	 * Create the frame.
	 */
	public FormInsertarPersonal(final BDMySQL bdMySQL) {
		//setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
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
		txtProfesion.setBounds(116, 116, 134, 28);
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
		
		//Botón Limpiar
		//Procedimiento de evento: Borra el contenido de los text boxes
		JButton btnLimpiar = new JButton("Limpiar");
		btnLimpiar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				txtNombre.setText("");
				txtApellidos.setText("");
				txtProfesion.setText("");
			}
		});
		btnLimpiar.setBounds(28, 186, 200, 29);
		contentPane.add(btnLimpiar);
		
		//Botón Insertar personas
		//Procedimiento de evento: Llama al método bdMySQL.insertarPersona() con los valores de los cuadros de texto
		JButton btnInsertar = new JButton("Insertar");
		btnInsertar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				bdMySQL.insertarPersona(txtNombre.getText(), txtApellidos.getText(), txtProfesion.getText());
			}
		});
		btnInsertar.setBounds(231, 186, 200, 29);
		contentPane.add(btnInsertar);
	}
}
