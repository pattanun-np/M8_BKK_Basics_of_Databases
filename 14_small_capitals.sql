-- capitals that are smaller than at least 3 other cities in the same country

SELECT co.Name AS Country, cap.Name AS Capital, cap.Population AS CapitalPop,
       COUNT(ci.ID) AS BiggerCities
FROM country co
JOIN city cap ON co.Capital = cap.ID
JOIN city ci ON ci.CountryCode = co.Code AND ci.Population > cap.Population
GROUP BY co.Name, cap.Name, cap.Population
HAVING COUNT(ci.ID) >= 3
ORDER BY BiggerCities DESC;
