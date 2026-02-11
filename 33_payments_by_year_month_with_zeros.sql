-- Payments aggregated by year and month, with 0 for months with no payments
SELECT
  y.year,
  mo.m AS month,
  COALESCE(SUM(p.amount), 0) AS total_payments
FROM
  (SELECT DISTINCT YEAR(payment_date) AS year FROM payment) AS y
CROSS JOIN
  (SELECT 1 AS m UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
   UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
   UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12) AS mo
LEFT JOIN payment p
  ON y.year = YEAR(p.payment_date)
  AND mo.m = MONTH(p.payment_date)
GROUP BY y.year, mo.m
ORDER BY y.year, mo.m;
