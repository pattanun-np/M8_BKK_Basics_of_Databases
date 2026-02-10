-- countries with no official language in the database

SELECT c.Name
FROM country c
WHERE NOT EXISTS (
  SELECT 1 FROM countrylanguage cl
  WHERE cl.CountryCode = c.Code AND cl.IsOfficial = 'T'
)
ORDER BY c.Name;
