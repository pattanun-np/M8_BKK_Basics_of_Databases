SELECT
  s.first_name ,
  s.last_name  ,
  DATE_FORMAT(p.payment_date, '%Y-%m') AS pay_month,
  f.film_id,
  f.title,
  COUNT(*) AS film_popular
FROM payment p
JOIN rental r
  ON p.rental_id = r.rental_id
JOIN inventory i
  ON r.inventory_id = i.inventory_id
JOIN film f
  ON i.film_id = f.film_id
JOIN staff s
 ON s.staff_id  = p.staff_id
GROUP BY
  p.staff_id,
  pay_month,
  f.film_id,
  f.title
ORDER BY
  pay_month,
  p.staff_id,
  film_popular DESC
LIMIT 1
