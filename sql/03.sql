/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */

SELECT DISTINCT c.customer_id
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN (
    SELECT top_films.film_id
    FROM (
        SELECT film.film_id, SUM(payment.amount) AS profit
        FROM payment
        JOIN rental ON payment.rental_id = rental.rental_id
        JOIN inventory ON rental.inventory_id = inventory.inventory_id
        JOIN film ON inventory.film_id = film.film_id
        GROUP BY film.film_id
        ORDER BY profit DESC
        LIMIT 5
    ) top_films
) top_films_subquery ON i.film_id = top_films_subquery.film_id;
