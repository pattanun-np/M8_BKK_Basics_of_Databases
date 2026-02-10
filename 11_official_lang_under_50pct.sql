-- countries where ALL official languages are spoken by less than 50% of the population

SELECT c.Name
FROM country c
WHERE c.Code IN (SELECT CountryCode FROM countrylanguage WHERE IsOfficial = 'T')
  AND NOT EXISTS (
    SELECT 1 FROM countrylanguage cl
    WHERE cl.CountryCode = c.Code
      AND cl.IsOfficial = 'T'
      AND cl.Percentage >= 50
  )
ORDER BY c.Name;
