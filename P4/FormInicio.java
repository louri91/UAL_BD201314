package es.ual.ualbd;

import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

public class FormInicio extends JFrame {

	private JPanel contentPane;

	/**
	 * Create the frame.
	 */
	public FormInicio(final BDMySQL bdMySQL) {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);

		//Bot—n A–adir datos
		//Procedimiento de evento: Carga datos de ejemplo en la base de datos
		JButton btnAgregarDatosBD = new JButton("A\u00F1adir datos a la base de datos");
		btnAgregarDatosBD.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				bdMySQL.inicializarBD();
			}
		});
		btnAgregarDatosBD.setBounds(82, 124, 296, 29);
		add(btnAgregarDatosBD);
		
		//Bot—n Mostrar datos
		//Procedimiento de evento: Muestra el formulario con el listado de las personas
		JButton btnMostrarDatos = new JButton("Mostrar datos");
		btnMostrarDatos.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				FormMostrarPersonal formMostrarPersonal = new FormMostrarPersonal(bdMySQL);
				formMostrarPersonal.setVisible(true);
			}
		});
		btnMostrarDatos.setBounds(82, 182, 117, 29);
		add(btnMostrarDatos);
		
		//Bot—n A–adir personas
		//Procedimiento de evento: Muestra el formulario para a–adir personas
		JButton btnAadirPersonas = new JButton("A\u00F1adir personas");
		btnAadirPersonas.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				FormInsertarPersonal formInsertarPersonal = new FormInsertarPersonal(bdMySQL);
				formInsertarPersonal.setVisible(true);
			}
		});
		btnAadirPersonas.setBounds(211, 182, 167, 29);
		add(btnAadirPersonas);
		
		JLabel lblEjemploDeUso = new JLabel("Ejemplo de uso de JDBC");
		lblEjemploDeUso.setBounds(150, 57, 161, 16);
		add(lblEjemploDeUso);

	}

}
