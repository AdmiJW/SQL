
/*
    Select the maximum, formatted to 4 d.p. only, for those LAT_N less than 137.2345
*/

SELECT
    FORMAT( MAX(LAT_N), 4)
FROM STATION
WHERE LAT_N < 137.2345;