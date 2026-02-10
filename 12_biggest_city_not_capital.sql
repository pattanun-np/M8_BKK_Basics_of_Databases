-- cities that are the most populated in their country but NOT the capital

SELECT ci.Name AS City, co.Name AS Country, ci.Population
FROM city ci
JOIN country co ON ci.CountryCode = co.Code
WHERE ci.ID != co.Capital
  AND ci.Population = (
    SELECT MAX(c2.Population)
    FROM city c2
    WHERE c2.CountryCode = ci.CountryCode
  )
ORDER BY ci.Population DESC;
