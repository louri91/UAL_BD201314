<?php
include_once ('constantesSakila.php');
$conexion = mysql_connect($host, $user, $password)
or die("Error al conectar con el servidor");
mysql_select_db($database, $conexion)
or die("Error al seleccionar la base de datos");
?>