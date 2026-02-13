-- ============================================================
-- Week 3 Lab: User Privileges & Access Control (Sakila DB)
-- ============================================================

-- ============================================================
-- Step 1: Create a User with Restricted Access
-- film_editor can read and modify only actor and film tables
-- ============================================================

CREATE USER 'film_editor'@'localhost' IDENTIFIED BY 'FilmEdit123!';

GRANT SELECT, INSERT, UPDATE, DELETE ON sakila.actor TO 'film_editor'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON sakila.film TO 'film_editor'@'localhost';

FLUSH PRIVILEGES;

-- Check privileges
SHOW GRANTS FOR 'film_editor'@'localhost';
-- Result:
-- GRANT USAGE ON *.* TO `film_editor`@`localhost`
-- GRANT SELECT, INSERT, UPDATE, DELETE ON `sakila`.`actor` TO `film_editor`@`localhost`
-- GRANT SELECT, INSERT, UPDATE, DELETE ON `sakila`.`film` TO `film_editor`@`localhost`


-- ============================================================
-- Step 2: Create a Read-Only User
-- film_viewer can only read data from actor and film tables
-- ============================================================

CREATE USER 'film_viewer'@'localhost' IDENTIFIED BY 'ViewOnly123!';

GRANT SELECT ON sakila.actor TO 'film_viewer'@'localhost';
GRANT SELECT ON sakila.film TO 'film_viewer'@'localhost';

FLUSH PRIVILEGES;

-- Check privileges
SHOW GRANTS FOR 'film_viewer'@'localhost';
-- Result:
-- GRANT USAGE ON *.* TO `film_viewer`@`localhost`
-- GRANT SELECT ON `sakila`.`actor` TO `film_viewer`@`localhost`
-- GRANT SELECT ON `sakila`.`film` TO `film_viewer`@`localhost`


-- ============================================================
-- Step 3: Test Access
-- ============================================================

-- === Test as film_editor ===
-- SELECT works:
SELECT * FROM film LIMIT 5;

-- INSERT works:
INSERT INTO actor (first_name, last_name) VALUES ('Test', 'Actor');
SELECT * FROM actor WHERE first_name = 'Test';

-- === Test as film_viewer ===
-- SELECT works:
SELECT * FROM actor LIMIT 5;

-- INSERT fails (as expected):
-- INSERT INTO actor (first_name, last_name) VALUES ('No', 'Permission');
-- ERROR 1142 (42000): INSERT command denied to user 'film_viewer'@'localhost' for table 'actor'


-- ============================================================
-- Step 4: Revoke Privileges
-- ============================================================

REVOKE INSERT ON sakila.actor FROM 'film_editor'@'localhost';

-- Verify revoke
SHOW GRANTS FOR 'film_editor'@'localhost';
-- Result:
-- GRANT USAGE ON *.* TO `film_editor`@`localhost`
-- GRANT SELECT, UPDATE, DELETE ON `sakila`.`actor` TO `film_editor`@`localhost`
-- GRANT SELECT, INSERT, UPDATE, DELETE ON `sakila`.`film` TO `film_editor`@`localhost`

-- Confirm INSERT is now denied for film_editor on actor:
-- INSERT INTO actor (first_name, last_name) VALUES ('Should', 'Fail');
-- ERROR 1142 (42000): INSERT command denied to user 'film_editor'@'localhost' for table 'actor'


-- ============================================================
-- Cleanup: Drop Users
-- ============================================================

DROP USER 'film_editor'@'localhost';
DROP USER 'film_viewer'@'localhost';
