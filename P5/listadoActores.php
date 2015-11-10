<html>
<head>
<link href="css/cssUAL.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<?php
	include_once ('conexionSakila.php');

	$cadenaSQL = "SELECT first_name,last_name, count(title) as totalPeliculas
from actor
LEFT OUTER join film_actor ON
actor.actor_id=film_actor.actor_id
left outer join film ON
film.film_id=film_actor.film_id
GROUP by last_name;";
	$resultado = mysql_query($cadenaSQL);

	echo "<h1>Listado de actores</h1>";
	echo "<table>";
	echo "<th><tr><td>Nombre</td><td>Apellidos</td><td>Total</td></tr></th>";
	while ($fila = mysql_fetch_object($resultado)) {
		echo "<tr>";
		echo "<td>" .  $fila->first_name . "<br/>"."</td>";
		echo "<td>" .  $fila->last_name . "<br/>"."</td>";
		echo "<td>" .  $fila->totalPeliculas . "<br/>"."</td>";
		echo "</tr>";
	}
	echo "</table>";

	echo "Total de promociones: " . mysql_num_rows($resultado) . "<br/>";

	mysql_close($conexion);
	?>
</body>
</html>