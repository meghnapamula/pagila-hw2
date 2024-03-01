/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT
film.title AS title
FROM film
JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN customer USING (customer_id)
LEFT JOIN address USING (address_id)
LEFT JOIN city USING (city_id)
GROUP BY film.title
HAVING COUNT(CASE WHEN city.country_id = 103 THEN 1 END) = 0
ORDER BY title;
