


/*          SORTING SOLUTION
(
    SELECT CITY, LENGTH(CITY) FROM STATION
    ORDER BY LENGTH(CITY) DESC, CITY
    LIMIT 1
)
UNION
(
    SELECT CITY, LENGTH(CITY) FROM STATION
    ORDER BY LENGTH(CITY), CITY
    LIMIT 1
);
*/

/*
    We will be going to UNION 2 results:
        > Minimum length city, the top result
        > Maximum length city, the top result
*/

/*      FILTERING SOLUTION      */
(
    SELECT CITY, LENGTH(CITY) FROM STATION
    HAVING LENGTH(CITY) = (
        SELECT MAX(LENGTH(CITY) ) FROM STATION
    )
    ORDER BY CITY
    LIMIT 1
) UNION (
    SELECT CITY, LENGTH(CITY) FROM STATION
    HAVING LENGTH(CITY) = (
        SELECT MIN(LENGTH(CITY) ) FROM STATION
    )
    ORDER BY CITY
    LIMIT 1
);
