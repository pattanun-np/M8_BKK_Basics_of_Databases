-- Staff members who did not sell anything in 2006
SELECT
  s.staff_id,
  s.first_name,
  s.last_name
FROM staff s
WHERE s.staff_id NOT IN (
  SELECT DISTINCT p.staff_id
  FROM payment p
  WHERE YEAR(p.payment_date) = 2006
);
