# Week 3 Lab: User Privileges & Access Control

**Database:** Sakila (MySQL 8.0)
**Date:** 2026-02-13
**Environment:** Docker container (`sakila-db`)

---

## Step 1: Create a User with Restricted Access

Create user `film_editor` who can read and modify only `actor` and `film` tables.

### SQL Executed

```sql
CREATE USER 'film_editor'@'localhost' IDENTIFIED BY 'FilmEdit123!';

GRANT SELECT, INSERT, UPDATE, DELETE ON sakila.actor TO 'film_editor'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON sakila.film TO 'film_editor'@'localhost';

FLUSH PRIVILEGES;
```

### SHOW GRANTS Result

```sql
SHOW GRANTS FOR 'film_editor'@'localhost';
```

```
Grants for film_editor@localhost
GRANT USAGE ON *.* TO `film_editor`@`localhost`
GRANT SELECT, INSERT, UPDATE, DELETE ON `sakila`.`actor` TO `film_editor`@`localhost`
GRANT SELECT, INSERT, UPDATE, DELETE ON `sakila`.`film` TO `film_editor`@`localhost`
```

---

## Step 2: Create a Read-Only User

Create user `film_viewer` who can only read data from `actor` and `film` tables.

### SQL Executed

```sql
CREATE USER 'film_viewer'@'localhost' IDENTIFIED BY 'ViewOnly123!';

GRANT SELECT ON sakila.actor TO 'film_viewer'@'localhost';
GRANT SELECT ON sakila.film TO 'film_viewer'@'localhost';

FLUSH PRIVILEGES;
```

### SHOW GRANTS Result

```sql
SHOW GRANTS FOR 'film_viewer'@'localhost';
```

```
Grants for film_viewer@localhost
GRANT USAGE ON *.* TO `film_viewer`@`localhost`
GRANT SELECT ON `sakila`.`actor` TO `film_viewer`@`localhost`
GRANT SELECT ON `sakila`.`film` TO `film_viewer`@`localhost`
```

---

## Step 3: Test Access

### 3a. Test as `film_editor`

**SELECT from film (should succeed):**

```sql
SELECT * FROM film LIMIT 5;
```

```
film_id  title             description                                          year
1        ACADEMY DINOSAUR  A Epic Drama of a Feminist And a Mad Scientist ...   2006
2        ACE GOLDFINGER    A Astounding Epistle of a Database Administrator ... 2006
3        ADAPTATION HOLES  A Astounding Reflection of a Lumberjack And a ...    2006
4        AFFAIR PREJUDICE  A Fanciful Documentary of a Frisbee And a ...        2006
5        AFRICAN EGG       A Fast-Paced Documentary of a Pastry Chef And ...    2006
```

> **Result:** SELECT succeeded

**INSERT into actor (should succeed):**

```sql
INSERT INTO actor (first_name, last_name) VALUES ('Test', 'Actor');
SELECT * FROM actor WHERE first_name = 'Test';
```

```
actor_id  first_name  last_name  last_update
201       Test        Actor      2026-02-13 08:44:21
```

> **Result:** INSERT succeeded

---

### 3b. Test as `film_viewer`

**SELECT from actor (should succeed):**

```sql
SELECT * FROM actor LIMIT 5;
```

```
actor_id  first_name  last_name     last_update
1         PENELOPE    GUINESS       2006-02-15 04:34:33
2         NICK        WAHLBERG      2006-02-15 04:34:33
3         ED          CHASE         2006-02-15 04:34:33
4         JENNIFER    DAVIS         2006-02-15 04:34:33
5         JOHNNY      LOLLOBRIGIDA  2006-02-15 04:34:33
```

> **Result:** SELECT succeeded

**INSERT into actor (should fail):**

```sql
INSERT INTO actor (first_name, last_name) VALUES ('No', 'Permission');
```

```
ERROR 1142 (42000): INSERT command denied to user 'film_viewer'@'localhost' for table 'actor'
```

> **Result:** INSERT denied — read-only user cannot modify data (expected)

---

## Step 4: Revoke Privileges

### SQL Executed

```sql
REVOKE INSERT ON sakila.actor FROM 'film_editor'@'localhost';
```

### SHOW GRANTS After Revoke

```sql
SHOW GRANTS FOR 'film_editor'@'localhost';
```

```
Grants for film_editor@localhost
GRANT USAGE ON *.* TO `film_editor`@`localhost`
GRANT SELECT, UPDATE, DELETE ON `sakila`.`actor` TO `film_editor`@`localhost`
GRANT SELECT, INSERT, UPDATE, DELETE ON `sakila`.`film` TO `film_editor`@`localhost`
```

> **Note:** INSERT is no longer listed for `sakila.actor` — revoke confirmed.

**Verify INSERT is now denied for film_editor:**

```sql
INSERT INTO actor (first_name, last_name) VALUES ('Should', 'Fail');
```

```
ERROR 1142 (42000): INSERT command denied to user 'film_editor'@'localhost' for table 'actor'
```

> **Result:** INSERT denied after REVOKE (expected)

---

## Cleanup

```sql
DROP USER 'film_editor'@'localhost';
DROP USER 'film_viewer'@'localhost';
```

> Both users successfully dropped.

---

## Summary

| Step | Action | Result |
|------|--------|--------|
| 1 | Create `film_editor` with CRUD on actor & film | Granted |
| 2 | Create `film_viewer` with SELECT-only on actor & film | Granted |
| 3a | `film_editor` SELECT film, INSERT actor | Both succeeded |
| 3b | `film_viewer` SELECT actor | Succeeded |
| 3c | `film_viewer` INSERT actor | Denied (expected) |
| 4 | REVOKE INSERT on actor from `film_editor` | Revoked — INSERT now denied |
| Cleanup | DROP both users | Removed |
