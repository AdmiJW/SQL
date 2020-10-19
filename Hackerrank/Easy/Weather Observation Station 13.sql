

/*
*   Find the sum of the latitude, rounded to 4 decimal places
*   where the latitude must be between 38.7880 and 137.2345
*/
SELECT ROUND( SUM(LAT_N), 4 ) FROM STATION
WHERE
    LAT_N BETWEEN 38.7880 AND 137.2345;