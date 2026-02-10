-- pairs of countries on different continents with population within 5% of each other

SELECT c1.Name AS Country1, c1.Continent AS Continent1, c1.Population AS Pop1,
       c2.Name AS Country2, c2.Continent AS Continent2, c2.Population AS Pop2,
       ROUND(ABS(c1.Population - c2.Population) / GREATEST(c1.Population, c2.Population) * 100, 1) AS DiffPct
FROM country c1
JOIN country c2 ON c1.Code < c2.Code
WHERE c1.Continent != c2.Continent
  AND c1.Population > 1000000 AND c2.Population > 1000000
  AND ABS(c1.Population - c2.Population) / GREATEST(c1.Population, c2.Population) <= 0.05
ORDER BY DiffPct;
