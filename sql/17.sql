/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */

SELECT
rank,
title,
revenue,
sum(revenue) OVER (ORDER BY revenue DESC) "total revenue"
FROM (SELECT
	RANK() OVER (
		ORDER BY sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) DESC) rank,
	film.title title,
	sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) revenue
	FROM film
	LEFT JOIN inventory USING (film_id)
	LEFT JOIN rental USING (inventory_id)
	LEFT JOIN payment USING (rental_id)
	GROUP BY 2 ORDER BY 3 DESC
) AS ranks
GROUP BY 1,2,3 ORDER BY 1,2;
