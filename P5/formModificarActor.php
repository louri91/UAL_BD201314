<!DOCtype html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<link href="css/cssUAL.css" rel="stylesheet" type="text/css" />
<title>Mofidicacion de actores</title>
</head>
<body>
	<?php
	include_once ('conexionSakila.php');

	$actor_id = $_GET['id'];

	$cadenaSQL = "SELECT * FROM Actor WHERE actor_id = '$actor_id';";
	$resultado = mysql_query($cadenaSQL);
	$fila = mysql_fetch_object($resultado);
	?>
	<h1>Formulario de modificacion de actores</h1>
	<form action="scriptModificarActor.php" method="get">
		<table>
			<tr>
				<td>id:</td>
				<td><input type="hidden" name="id"
					value="<?php echo $fila->actor_id;?>"></td>
			</tr>
			<tr>
				<td>Nombre:</td>
				<td><input type="text" name="first_name"
					value="<?php echo $fila->first_name;?>"></td>
			</tr>
			<tr>
				<td>Apellidos:</td>
				<td><input type="text" name="last_name"
					value="<?php echo $fila->last_name;?>"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="Modificar"> <a href='listadoActoresDML.php'><input
						type="button" value="Volver atras"> </a>
				</td>
			</tr>
			</form>
		</table>
		<?php 
		mysql_close ($conexion);
		?>

</body>
</html>
