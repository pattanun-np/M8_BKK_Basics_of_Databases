-- check all tables in the world database

SHOW TABLES;

-- table structures
DESCRIBE city;
DESCRIBE country;
DESCRIBE countrylanguage;

-- how many records each table has
SELECT COUNT(*) FROM city;          -- 4079
SELECT COUNT(*) FROM country;       -- 239
SELECT COUNT(*) FROM countrylanguage; -- 984

-- joins:
-- city and country can be joined on city.CountryCode = country.Code
-- countrylanguage and country joined on countrylanguage.CountryCode = country.Code
-- country.Capital references city.ID (the capital city)
