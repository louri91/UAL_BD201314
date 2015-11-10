<!DOCtype html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<link href="css/cssUAL.css" rel="stylesheet" type="text/css" />
<title>Insercion de Actores</title>
</head>
<body>
	<?php
	include_once ('conexionSakila.php');

	$nombre = $_GET['nombre'];
	$apellidos = $_GET['apellidos'];

	$cadenaSQL = "INSERT INTO Actor(first_name, last_name, last_update) VALUES('$nombre', '$apellidos', CURRENT_TIMESTAMP)";
	mysql_query($cadenaSQL);

	if (mysql_affected_rows($conexion) == 1){
	echo "Actor insertado con exito<br/>";
}
else {
	echo "Actor no insertado<br/>";
}

mysql_close($conexion);
?>
	<a href='formInsertarActor.html'>Volver atras</a>
</body>
</html>
