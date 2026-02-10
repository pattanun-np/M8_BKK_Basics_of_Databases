SELECT
  s.staff_id,
  s.first_name,
  s.last_name
FROM staff s
LEFT JOIN payment p
  ON p.staff_id = s.staff_id
 AND p.payment_date >= '2006-01-01'
 AND p.payment_date <  '2007-01-01'
WHERE p.payment_id IS NULL;
