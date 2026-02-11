## Fix: Payments aggregated by year and month (with 0 for empty months)

### Broken query

```sql
use world;
SELECT
  YEAR(payment_date)     AS year,
  MONTH(payment_date)   AS month,
  mo.m,
  SUM(amount)   AS total_payments
FROM
(SELECT DISTINCT YEAR(payment_date) as year FROM payment) AS y,
(
SELECT 1 AS m
UNION ALL SELECT 2 AS m
UNION ALL SELECT 3 AS m
UNION ALL SELECT 4 AS m
UNION ALL SELECT 5 AS m
UNION ALL SELECT 6 AS m
UNION ALL SELECT 7 AS m
UNION ALL SELECT 8 AS m
UNION ALL SELECT 9 AS m
UNION ALL SELECT 10 AS m
UNION ALL SELECT 11 AS m
UNION ALL SELECT 12 AS m) mo
LEFT JOIN
payment ON mo.m = MONTH(payment_date)
GROUP BY YEAR(payment_date), MONTH(payment_date), mo.m
ORDER BY year, month;
```

### Issues

| # | Problem | Fix |
|---|---------|-----|
| 1 | `use world` — payment table is in `sakila` | `use sakila` |
| 2 | LEFT JOIN only matches on `MONTH`, not `YEAR` — payments from all years bleed together | Add `y.year = YEAR(p.payment_date)` to JOIN |
| 3 | SELECT/GROUP BY uses `YEAR(payment_date)` which is NULL for empty months | Use `y.year` and `mo.m` instead |
| 4 | No `COALESCE` — empty months show NULL instead of 0 | Wrap with `COALESCE(..., 0)` |

### Fixed query

```sql
use sakila;

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
```
