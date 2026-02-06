-- find the smallest country (by surface area)

SELECT Name, SurfaceArea
FROM country
WHERE SurfaceArea > 0
ORDER BY SurfaceArea
LIMIT 1;

-- result: Holy See (Vatican City State), 0.40 km2

-- also by population
SELECT Name, Population
FROM country
WHERE Population > 0
ORDER BY Population
LIMIT 1;

-- result: Pitcairn, 50 people
