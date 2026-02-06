-- countries whose population is greater than the average population of all countries

SELECT Name, Population
FROM country
WHERE Population > (SELECT AVG(Population) FROM country)
ORDER BY Population DESC;
