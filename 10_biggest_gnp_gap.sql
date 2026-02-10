-- which region has the biggest gap between richest and poorest country by GNP?

SELECT Region,
       MAX(GNP) - MIN(GNP) AS GNP_Gap,
       MAX(GNP) AS Richest_GNP,
       MIN(GNP) AS Poorest_GNP
FROM country
WHERE GNP > 0
GROUP BY Region
ORDER BY GNP_Gap DESC
LIMIT 1;
