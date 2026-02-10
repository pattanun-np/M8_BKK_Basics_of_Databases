SELECT
  f.film_id,
  f.title
FROM film f
LEFT JOIN inventory i
  ON i.film_id = f.film_id
LEFT JOIN rental r
  ON r.inventory_id = i.inventory_id
WHERE r.rental_id IS NULL
GROUP BY f.film_id, f.title
LIMIT 1;

---

SELECT
  f.film_id,
  f.title
FROM film f
WHERE NOT EXISTS (
  SELECT 1
  FROM inventory i
  JOIN rental r
    ON r.inventory_id = i.inventory_id
  JOIN payment p
    ON p.rental_id = r.rental_id
  WHERE i.film_id = f.film_id
    AND p.payment_date >= '2006-01-01'
    AND p.payment_date <  '2007-01-01'
)
ORDER BY f.film_id;
