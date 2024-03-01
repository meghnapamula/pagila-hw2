/*
 * Compute the total revenue for each film.
 */

SELECT
film.title title,
sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) revenue
FROM film
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN payment USING (rental_id)
GROUP BY 1 ORDER BY 2 DESC;
