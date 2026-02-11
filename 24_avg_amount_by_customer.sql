SELECT
  c.first_name,
  c.last_name,
  AVG(p.amount) AS avg_amount
FROM payment p
JOIN customer c
	ON c.customer_id  = p.customer_id
GROUP BY p.customer_id
ORDER BY p.customer_id;
