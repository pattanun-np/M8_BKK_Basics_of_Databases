SELECT
  DATE_FORMAT(p.payment_date, '%Y-%m') AS pay_month,
  f.title,
  COUNT(*) AS film_popular
FROM payment p
JOIN rental r
  ON p.rental_id = r.rental_id
JOIN inventory i
  ON r.inventory_id = i.inventory_id
JOIN film f
  ON i.film_id = f.film_id
GROUP BY
  DATE_FORMAT(p.payment_date, '%Y-%m'),
  f.title
ORDER BY pay_month, film_popular DESC;
