SELECT
  MIN(payment_date) AS first_payment,
  MAX(payment_date) AS last_payment
FROM payment;
