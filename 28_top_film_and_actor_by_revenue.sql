-- Which film brings the most money?
SELECT
  f.film_id,
  f.title,
  SUM(p.amount) AS total_revenue,
  COUNT(p.payment_id) AS total_rentals
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY total_revenue DESC
LIMIT 10;

-- Which actor brings the most money?
SELECT
  a.actor_id,
  a.first_name,
  a.last_name,
  SUM(p.amount) AS total_revenue,
  COUNT(p.payment_id) AS total_rentals
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_revenue DESC
LIMIT 10;
