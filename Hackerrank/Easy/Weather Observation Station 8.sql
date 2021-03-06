
/* REGULAR EXPRESSION SOLUTION */
SELECT DISTINCT CITY FROM STATION
WHERE
    REGEXP_LIKE(CITY, '^[AEIOU].*[aeiou]$');


/* SUBSTRING SOLUTION */  
SELECT DISTINCT CITY FROM STATION
WHERE
    SUBSTR( CITY, 0, 1) IN ('A','E','I','O','U') AND
    SUBSTR( CITY, -1 ) IN ('a','e','i','o','u');