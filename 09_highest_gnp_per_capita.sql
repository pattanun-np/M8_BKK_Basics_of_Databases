-- for each continent, which country has the highest GNP per capita?

SELECT sub.Continent, sub.Name, sub.GNPPerCapita
FROM (
  SELECT Continent, Name,
         ROUND(GNP * 1000000 / Population, 2) AS GNPPerCapita,
         ROW_NUMBER() OVER (PARTITION BY Continent ORDER BY GNP/Population DESC) AS rn
  FROM country
  WHERE Population > 0 AND GNP > 0
) sub
WHERE sub.rn = 1;
