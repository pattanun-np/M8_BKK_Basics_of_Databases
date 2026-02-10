-- countries that speak a language no other country speaks (> 5% speakers)

SELECT c.Name AS Country, cl.Language
FROM countrylanguage cl
JOIN country c ON cl.CountryCode = c.Code
WHERE cl.Language IN (
  SELECT Language
  FROM countrylanguage
  GROUP BY Language
  HAVING COUNT(DISTINCT CountryCode) = 1
)
AND cl.Percentage > 5
ORDER BY c.Name;
