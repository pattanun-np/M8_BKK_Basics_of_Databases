-- "Tiny but Mighty" countries
-- smaller population than Tokyo but higher life expectancy than the global average

SELECT Name, Population, LifeExpectancy
FROM country
WHERE Population < (SELECT Population FROM city WHERE Name = 'Tokyo')
  AND LifeExpectancy > (SELECT AVG(LifeExpectancy) FROM country WHERE LifeExpectancy IS NOT NULL)
ORDER BY LifeExpectancy DESC;
