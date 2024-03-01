/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */

SELECT
RANK() OVER (
	ORDER BY sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) DESC) rank,
film.title title,
sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) revenue
FROM film
LEFT JOIN inventory USING (film_id)
LEFT JOIN rental USING (inventory_id)
LEFT JOIN payment USING (rental_id)
GROUP BY 2 ORDER BY 3 DESC;
