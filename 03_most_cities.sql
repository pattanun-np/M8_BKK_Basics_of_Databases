-- which country has the most cities in the database

SELECT co.Name, COUNT(*) AS total_cities
FROM city ci
JOIN country co ON ci.CountryCode = co.Code
GROUP BY co.Name
ORDER BY total_cities DESC
LIMIT 1;

-- result: China, 363 cities
