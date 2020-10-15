/* SUBSTRING SOLUTION */
SELECT DISTINCT CITY FROM STATION
WHERE
    SUBSTR(CITY, 0, 1) NOT IN ('A','E','I','O','U') OR
    SUBSTR(CITY, -1) NOT IN ('a','e','i','o','u');


/* REGULAR EXPRESSION SOLUTION */
SELECT DISTINCT CITY FROM STATION 
WHERE
    REGEXP_LIKE(CITY, '^[^AEIOU]') OR
    REGEXP_LIKE(CITY, '[^aeiou]$');
