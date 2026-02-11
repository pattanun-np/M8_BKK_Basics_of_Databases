-- Customers from which city pay the most money?
SELECT
  ci.city,
  co.country,
  SUM(p.amount) AS total_revenue,
  COUNT(p.payment_id) AS total_payments,
  COUNT(DISTINCT c.customer_id) AS total_customers
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY ci.city_id, ci.city, co.country
ORDER BY total_revenue DESC
LIMIT 10;
