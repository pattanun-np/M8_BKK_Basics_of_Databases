-- top 3 most spoken languages in the world by total speakers

SELECT cl.Language,
       ROUND(SUM(c.Population * cl.Percentage / 100)) AS TotalSpeakers
FROM countrylanguage cl
JOIN country c ON cl.CountryCode = c.Code
GROUP BY cl.Language
ORDER BY TotalSpeakers DESC
LIMIT 3;
