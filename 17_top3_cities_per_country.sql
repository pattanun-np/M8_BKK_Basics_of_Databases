-- rank cities by population within each country, show only top 3

SELECT Country, City, Population, rnk FROM (
  SELECT co.Name AS Country, ci.Name AS City, ci.Population,
         ROW_NUMBER() OVER (PARTITION BY co.Code ORDER BY ci.Population DESC) AS rnk
  FROM city ci
  JOIN country co ON ci.CountryCode = co.Code
) ranked
WHERE rnk <= 3
ORDER BY Country, rnk;
