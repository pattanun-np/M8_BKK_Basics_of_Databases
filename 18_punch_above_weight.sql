-- percentage of world population vs world GNP per continent
-- "punch ratio" > 1 means the continent produces more GNP than its share of population

SELECT Continent,
       ROUND(SUM(Population) / (SELECT SUM(Population) FROM country) * 100, 1) AS PopPct,
       ROUND(SUM(GNP) / (SELECT SUM(GNP) FROM country) * 100, 1) AS GNPPct,
       ROUND(
         (SUM(GNP) / (SELECT SUM(GNP) FROM country)) /
         (SUM(Population) / (SELECT SUM(Population) FROM country)),
         2
       ) AS PunchRatio
FROM country
WHERE Population > 0
GROUP BY Continent
ORDER BY PunchRatio DESC;
