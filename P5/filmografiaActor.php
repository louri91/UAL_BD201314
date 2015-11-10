<html>
<head>
<link href="css/cssUAL.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php
include_once ('conexionSakila.php');

$id = $_GET['id'];

$cadenaSQL = "SELECT title, length
FROM film, sakila.actor, film_actor
WHERE actor.actor_id= film_actor.actor_id
AND film_actor.film_id = film.film_id
AND actor.actor_id = $id";
$resultado = mysql_query($cadenaSQL);

echo "<h1>Listado de peliculas de un actor</h1>";
echo "<table>";
echo "<th><tr><td>Pelicula</td></tr></th>";
while ($fila = mysql_fetch_object($resultado)) {
	echo "<tr>";
	echo "<td>" . $fila->title . "</td>";
	echo "</tr>";
}
echo "</table>";

mysql_close($conexion);
?>
</body>
</html>