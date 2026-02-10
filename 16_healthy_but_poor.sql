-- countries with life expectancy above their continent avg
-- but GNP per capita below their continent avg

SELECT c.Name, c.Continent, c.LifeExpectancy,
       ROUND(c.GNP * 1000000 / c.Population, 2) AS GNPPerCapita
FROM country c
JOIN (
  SELECT Continent,
         AVG(LifeExpectancy) AS AvgLE,
         AVG(GNP * 1000000 / Population) AS AvgGNPPC
  FROM country
  WHERE Population > 0 AND LifeExpectancy IS NOT NULL AND GNP IS NOT NULL
  GROUP BY Continent
) cont ON c.Continent = cont.Continent
WHERE c.Population > 0
  AND c.LifeExpectancy > cont.AvgLE
  AND (c.GNP * 1000000 / c.Population) < cont.AvgGNPPC
ORDER BY c.Continent, c.Name;
