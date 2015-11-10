1

SELECT name, count(title) as totalPeliculas
FROM category, film_category, film
WHERE film.film_id= film_category.film_id 
AND film_category.category_id=category.category_id
AND film.length>'90'
AND category.name IN ('Children','Classics', 'Comedy')
GROUP BY name;


2

SELECT count(title) as totalPeliculas
FROM film, film_actor, actor
WHERE actor.actor_id=film_actor.actor_id
AND film.film_id=film_actor.film_id
AND film.length>100
AND actor.first_name='Ed' AND actor.last_name='Chase';

3

SELECT title, count(actor.first_name) as totalActores
FROM film, category, film_category, actor, film_actor
WHERE film.film_id=film_category.film_id
AND category.category_id=film_category.category_id
AND film.film_id=film_actor.film_id
AND film_actor.actor_id=actor.actor_id
AND category.name='Action'
AND film.length>'180'
GROUP BY title;

4

SELECT film.film_id, count(inventory.film_id) as totalPeliculas
FROM inventory, film
WHERE inventory.film_id= film.film_id AND film.film_id IN
(SELECT film_id
FROM film
WHERE length>180 AND rating='G' AND special_features like '%Trailers%')
GROUP BY film.film_id;

5

SELECT title, count(inventory.film_id) as totalPeliculas
FROM film, inventory
WHERE film.film_id = inventory.film_id AND film.film_id IN
(SELECT film_id
FROM film
WHERE length > 180 AND rating = "G" AND special_features like '%Trailers%')
GROUP by film.title;

6

SELECT title, alquilados.totalAlquilados
FROM film,
(SELECT film.film_id, count(rental.inventory_id) as totalAlquilados
FROM film, rental, inventory
WHERE film.film_id = inventory.film_id AND inventory.inventory_id = rental.inventory_id 
AND length > 90
GROUP by film.film_id 
HAVING count(rental.inventory_id) > 30) as alquilados
WHERE film.film_id = alquilados.film_id;

7

SELECT title
FROM film 
WHERE length > 180 AND film.film_id NOT IN (SELECT film.film_id
FROM film, rental, inventory
WHERE film.film_id = inventory.film_id AND inventory.inventory_id = rental.inventory_id
GROUP by film.film_id);

8

SELECT first_name, last_name, count(film.title) AS totalAlquileres
FROM customer, rental, inventory, film
WHERE customer.customer_id = rental.customer_id 
AND rental.inventory_id = inventory.inventory_id AND inventory.film_id = film.film_id AND 
film.film_id IN (SELECT film.film_id
FROM category, film_category, film
WHERE category.category_id = film_category.category_id 
AND film_category.film_id = film.film_id AND length > 90 
AND category.name IN ("Children", "Classics", "Comedy")) 
GROUP by customer.customer_id
having count(film.title) > 8
ORDER by last_name;


9

SELECT country, count(customer_id) AS totalClientes
FROM country, city, address, customer
WHERE country.country_id = city.country_id AND city.city_id = address.city_id 
AND address.address_id = customer.address_id
GROUP by country.country_id
having count(customer_id) > 40;


10

SELECT city.city
FROM country, city, address, customer, rental
WHERE rental.customer_id = customer.customer_id AND customer.address_id = address.address_id 
AND address.city_id = city.city_id 
AND city.country_id = country.country_id AND country = "Spain" AND rental.rental_id IN 
(SELECT rental.rental_id
FROM film, inventory, rental
WHERE film.film_id = inventory.film_id AND inventory.inventory_id = rental.inventory_id 
AND film.rating = "G")
GROUP by city
having count(rental.customer_id) = 5;

