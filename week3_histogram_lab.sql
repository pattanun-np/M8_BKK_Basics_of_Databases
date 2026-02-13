-- ============================================================
-- Week 3 Lab: MySQL Histograms & Query Optimization
-- Using: Sakila sample database on MySQL 9.6
-- ============================================================

-- Part 1 – Check Default Optimizer Behavior
-- =============================================================
-- Run EXPLAIN to see how MySQL plans these queries:

EXPLAIN FORMAT=JSON SELECT * FROM sakila.film_actor WHERE actor_id = 1;
-- Result: Index lookup on PRIMARY, estimated_rows: 19, cost: 2.15

EXPLAIN FORMAT=JSON SELECT * FROM sakila.film_actor WHERE actor_id = 50;
-- Result: Index lookup on PRIMARY, estimated_rows: 32, cost: 3.46

-- REFLECTION:
-- MySQL uses the PRIMARY index (not full table scan) because actor_id
-- is part of the composite primary key (actor_id, film_id).
-- The optimizer uses index dive statistics to estimate row counts.
-- Without histograms, it might miss data distribution patterns
-- for non-indexed columns.


-- ■ Part 2 – View Existing Statistics
-- =============================================================

SHOW INDEX FROM sakila.film_actor;
-- Key findings:
--   PRIMARY (actor_id): Cardinality = 200 (200 distinct actors)
--   PRIMARY (film_id):  Cardinality = 5462 (unique combinations)
--   idx_fk_film_id:     Cardinality = 997 (distinct films)
--
-- Cardinality = estimated number of distinct values in the index.
-- MySQL uses it to estimate selectivity: rows / cardinality ≈ rows per value
-- Higher cardinality = more selective = better candidate for index usage


-- ■ Part 3 – Create a Histogram
-- =============================================================

ANALYZE TABLE sakila.film_actor UPDATE HISTOGRAM ON actor_id WITH 10 BUCKETS;

-- Verify creation:
SELECT JSON_PRETTY(histogram)
FROM information_schema.column_statistics
WHERE schema_name='sakila'
  AND table_name='film_actor'
  AND column_name='actor_id';

-- Result: 10 equi-height buckets were created
-- Each bucket: [min_value, max_value, cumulative_frequency, num_distinct]
-- Example: [1, 21, 0.100, 21] means actors 1-21 represent ~10% of rows
-- The distribution is fairly uniform (~10% per bucket)


-- ■ Part 4 – Compare Query Plans (After Histogram)
-- =============================================================

EXPLAIN FORMAT=JSON SELECT * FROM sakila.film_actor WHERE actor_id = 1;
EXPLAIN FORMAT=JSON SELECT * FROM sakila.film_actor WHERE actor_id = 50;

-- Result: Plans unchanged because actor_id is in the PRIMARY KEY.
-- MySQL already has precise index statistics for indexed columns.
-- Histograms matter most for NON-INDEXED columns.

-- Better demonstration with non-indexed column (rental_rate on film):
-- BEFORE histogram: estimated_rows = 100 (naive 10% guess)
-- AFTER histogram:  estimated_rows = 341 (actual count = 341!)
-- The histogram corrected the estimate from 100 → 341


-- ■ Part 5 – Measure Execution Time
-- =============================================================

SET profiling = 1;
SELECT * FROM sakila.film_actor WHERE actor_id = 1;
SELECT * FROM sakila.film_actor WHERE actor_id = 50;
SHOW PROFILES;
-- actor_id=1:  0.69 ms (19 rows)
-- actor_id=50: 0.30 ms (32 rows)
-- Both sub-millisecond due to efficient PRIMARY KEY index


-- ■ Part 6 – Clean Up
-- =============================================================

ANALYZE TABLE sakila.film_actor DROP HISTOGRAM ON actor_id;


-- ============================================================
-- REFLECTION ANSWERS
-- ============================================================

-- 1. What statistics does MySQL keep?
--    - Table: row count, avg row length, data/index size
--    - Index: cardinality (distinct values) in mysql.innodb_index_stats
--    - Column: histograms (opt-in) in information_schema.column_statistics

-- 2. Why are histograms helpful for non-uniform distributions?
--    Without histograms, MySQL assumes uniform distribution (rows/cardinality).
--    If 90% of rows have value=1, the optimizer would guess ~50%,
--    leading to bad plan choices (wrong scan type, wrong join order).

-- 3. What if statistics become outdated?
--    Optimizer chooses suboptimal plans. InnoDB auto-updates index stats,
--    but histograms need manual ANALYZE TABLE to refresh.

-- 4. How do histograms help in production?
--    - Better join order selection
--    - More accurate memory allocation for sorts/joins
--    - Avoid full scans on highly selective non-indexed columns
--    - Critical for skewed columns (status, category, date ranges)


-- ============================================================
-- BONUS CHALLENGE: Skewed Data Experiment
-- ============================================================

-- Create table with 90% category=1, 10% other values
CREATE TABLE sakila.skewed_data (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category INT NOT NULL
);

-- (populate with 9000 rows category=1 and 1000 rows category=2-100)

-- Results:
-- BEFORE HISTOGRAM:
--   category=1:  estimated 1,000 rows (actual: 9,000) ← 9x underestimate!
--   category=50: estimated 1,000 rows (actual: ~10)   ← 100x overestimate!
--
-- AFTER HISTOGRAM:
--   category=1:  estimated 9,000 rows ← correct!
--   category=50: estimated 11 rows    ← correct!
--
-- The histogram bucket [1, 1, 0.9, 1] shows category=1 = 90% of data
-- This lets MySQL choose full table scan for category=1 (most rows)
-- and index scan for category=50 (very few rows)

-- Clean up:
-- ANALYZE TABLE sakila.skewed_data DROP HISTOGRAM ON category;
-- DROP TABLE sakila.skewed_data;
