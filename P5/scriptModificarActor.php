<!DOCtype html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<link href="css/cssUAL.css" rel="stylesheet" type="text/css" />
<title>Modificacion de actores</title>
</head>
<body>
	<?php
	include_once ('conexionSakila.php');

	//	Obtener los valores pasados por GET
	$id = $_GET['id'];
	$nombre = $_GET['first_name'];
	$apellidos = $_GET['last_name'];

	//Modificar la promoci—n pasada como par‡metro
	$cadenaSQL = "UPDATE Actor SET first_name = '$nombre', last_name = '$apellidos' WHERE actor_id = $id";
	mysql_query($cadenaSQL);

	if (mysql_affected_rows($conexion) == 1){
	echo "Actor modificado con exito<br/>";
}
else {
	echo "Actor no modificado<br/>";
}

//	Cerrar la conexi—n
mysql_close($conexion);
?>
	<a href='listadoActoresDML.php'>Volver atras</a>
</body>
</html>
