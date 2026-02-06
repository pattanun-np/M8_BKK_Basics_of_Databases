-- cities whose population is larger than their country's average city population

SELECT ci.Name, ci.Population, ci.CountryCode
FROM city ci
WHERE ci.Population > (
    SELECT AVG(c2.Population)
    FROM city c2
    WHERE c2.CountryCode = ci.CountryCode
)
ORDER BY ci.Population DESC;
