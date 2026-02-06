-- find the capital city of Spain

SELECT ci.Name
FROM country co
JOIN city ci ON co.Capital = ci.ID
WHERE co.Name = 'Spain';

-- result: Madrid
