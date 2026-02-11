SELECT
  YEAR(payment_date) AS year,
  MONTH(payment_date) AS month,
  COUNT(*) AS total_payments,
  SUM(amount) AS total_amount
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date)
ORDER BY year, month;
