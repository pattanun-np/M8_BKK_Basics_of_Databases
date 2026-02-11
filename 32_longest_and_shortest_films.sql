-- Find the longest and shortest films
(SELECT 'Longest' AS type, film_id, title, length
 FROM film
 ORDER BY length DESC
 LIMIT 5)
UNION ALL
(SELECT 'Shortest' AS type, film_id, title, length
 FROM film
 ORDER BY length ASC
 LIMIT 5);
