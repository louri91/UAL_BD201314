1
SELECT first_name, last_name, district, phone
FROM `sakila`.`customer`, `sakila`.`address` , `sakila`.`city`, `sakila`.`country`
WHERE `sakila`.`customer`.`address_id`=`sakila`.`address`.`address_id` 
AND `sakila`.`address`.`city_id` = `sakila`.`city`.`city_id`
AND `sakila`.`city`.`country_id` = `sakila`.`country`.`country_id`
AND district != 'Galicia' AND `sakila`.`country`.`country` = 'Spain';

2
SELECT first_name, last_name
FROM `sakila`.`customer`, `sakila`.`film`, `sakila`.`rental`, `sakila`.`inventory`
WHERE `sakila`.`customer`.`customer_id` = `sakila`.`rental`.`customer_id` 
AND `sakila`.`rental`.`inventory_id` = `sakila`.`inventory`.`inventory_id` 
AND `sakila`.`inventory`.`film_id` = `sakila`.`film`.`film_id` 
AND `sakila`.`film`.`title` = 'ACE GOLDFINGER'
ORDER BY last_name;

3
SELECT title, length, rating
FROM `sakila`.`film`, `sakila`.`film_category`, `sakila`.`category`
WHERE `sakila`.`film`.`film_id`= `sakila`.`film_category`.`film_id` AND 
`sakila`.`category`.`category_id`= `sakila`.`film_category`.`category_id`
 AND `sakila`.`film`.`title` LIKE '% ARIZONA' 
AND `sakila`.`category`.`name`= 'Action';

4

SELECT title, rental_duration, length
FROM `sakila`.`film`
WHERE `sakila`.`film`.`SPECIAL_FEATURES` LIKE '%Trailers%' 
AND `sakila`.`film`.`rating`='PG'
AND `sakila`.`film`.`rental_duration` BETWEEN '6' AND '7'
AND `sakila`.`film`.`length` BETWEEN '80' AND '90' 
ORDER BY title;



5

SELECT first_name, last_name, title
FROM `sakila`.`actor`,`sakila`.`film`, `sakila`.`film_actor`
WHERE `sakila`.`film`.`SPECIAL_FEATURES` LIKE '%Trailers%' 
AND `sakila`.`film`.`rating`='PG'
AND `sakila`.`film`.`rental_duration` BETWEEN '6' AND '7'
AND `sakila`.`film`.`length` BETWEEN '80' AND '90' 
AND `sakila`.`actor`.`actor_id`= `sakila`.`film_actor`.`actor_id`
AND `sakila`.`film_actor`.`film_id` = `sakila`.`film`.`film_id`
AND first_name = 'JAYNE'
ORDER BY title;

6

SELECT title, length
FROM `sakila`.`film`, `sakila`.`actor`, `sakila`.`film_actor`
WHERE `sakila`.`actor`.`actor_id`= `sakila`.`film_actor`.`actor_id`
AND `sakila`.`film_actor`.`film_id` = `sakila`.`film`.`film_id`
AND first_name = 'JAYNE' AND `sakila`.`actor`.`last_name`= 'NOLTE'
AND `sakila`.`film`.`rating`='PG'
AND `sakila`.`film`.`length`>'120';


7

SELECT first_name, last_name
FROM `sakila`.`customer`, `sakila`.`address` , `sakila`.`city`, `sakila`.`country`
WHERE `sakila`.`customer`.`address_id`=`sakila`.`address`.`address_id` 
AND `sakila`.`address`.`city_id` = `sakila`.`city`.`city_id`
AND `sakila`.`city`.`country_id` = `sakila`.`country`.`country_id`
AND `sakila`.`country`.`country`='Spain';


8


SELECT title
FROM film, customer, rental, inventory
WHERE customer.customer_id = rental.customer_id 
AND inventory.inventory_id = rental.inventory_id 
AND film.film_id= inventory.film_id AND film.length>180 AND customer.customer_id IN
(SELECT customer_id
FROM `sakila`.`customer`, `sakila`.`address` , `sakila`.`city`, `sakila`.`country`
WHERE `sakila`.`customer`.`address_id`=`sakila`.`address`.`address_id` 
AND `sakila`.`address`.`city_id` = `sakila`.`city`.`city_id`
AND `sakila`.`city`.`country_id` = `sakila`.`country`.`country_id`
AND `sakila`.`country`.`country`='Spain')
group by title;


9


SELECT first_name, last_name
FROM staff, store
WHERE staff.store_id= store.store_id AND store.store_id IN
(SELECT store_id
FROM store, address, city, country
WHERE store.address_id=address.address_id 
AND address.city_id=city.city_id
AND city.country_id=country.country_id
AND country='Australia');

10


SELECT first_name, last_name
FROM customer
WHERE customer_id IN 
(SELECT rental.customer_id
FROM rental, staff
WHERE datediff(return_date, rental_date) = 10
AND MONTH(return_date) = 6
AND staff.first_name = "Mike" AND staff.last_name = "Hillyer"
AND staff.staff_id = rental.staff_id)
ORDER BY last_name;


