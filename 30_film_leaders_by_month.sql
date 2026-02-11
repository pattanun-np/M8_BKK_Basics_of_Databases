-- Films that were leaders by month (highest revenue per month)
WITH monthly_revenue AS (
  SELECT
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    f.film_id,
    f.title,
    SUM(p.amount) AS total_revenue,
    COUNT(p.payment_id) AS total_rentals,
    RANK() OVER (
      PARTITION BY YEAR(p.payment_date), MONTH(p.payment_date)
      ORDER BY SUM(p.amount) DESC
    ) AS rnk
  FROM payment p
  JOIN rental r ON p.rental_id = r.rental_id
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
  GROUP BY YEAR(p.payment_date), MONTH(p.payment_date), f.film_id, f.title
)
SELECT year, month, title, total_revenue, total_rentals
FROM monthly_revenue
WHERE rnk = 1
ORDER BY year, month;
