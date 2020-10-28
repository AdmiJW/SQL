

/*
SUBQUERY SOLUTION
*/
SELECT FORMAT(
    temp.c - temp.a + temp.d - temp.b
, 4) AS "Manhattan Distance"
FROM (
    SELECT 
        MIN(LAT_N) AS a,
        MIN(LONG_W) AS b,
        MAX(LAT_N) AS c,
        MAX(LONG_W) AS d
    FROM STATION,
) AS temp;


/*
SHORTER QUERY SOLUTION
*/
SELECT FORMAT(
    MAX(LAT_N) + MAX(LONG_W) - MIN(LAT_N) - MIN(LONG_W)
, 4) AS "Manhattan Distance"
FROM STATION;