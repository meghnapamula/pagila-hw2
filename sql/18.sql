/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */

SELECT
rank,
title,
revenue,
"total revenue",
to_char(100*"total revenue"/(
		SELECT sum(amount)
		FROM film
		LEFT JOIN inventory USING (film_id)
		LEFT JOIN rental USING (inventory_id)
		LEFT JOIN payment USING (rental_id)
), 'FM900.00') AS "percent revenue"
FROM (
	SELECT
	rank,
	title,
	revenue,
	sum(revenue) OVER (ORDER BY revenue DESC) "total revenue"
	FROM (
		SELECT
		RANK() OVER(
			ORDER BY sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) DESC) rank,
		film.title title,
		sum(CASE WHEN amount IS NULL THEN 0.00 ELSE amount END) revenue
		FROM film
		LEFT JOIN inventory USING (film_id)
		LEFT JOIN rental USING (inventory_id)
		LEFT JOIN payment USING (rental_id)
		GROUP BY 2 ORDER BY 3 DESC
	) AS sixteen
	GROUP BY 1,2,3 ORDER BY 1,2
) AS seventeen
GROUP BY 1,2,3,4;
