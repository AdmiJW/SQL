

/* Direct Formula Solution */

-- SELECT ROUND(
--     SQRT(
--         POW( MAX(LAT_N) - MIN(LAT_N), 2) +
--         POW( MAX(LONG_W) - MIN(LONG_W), 2 )
--      )
-- , 4) FROM STATION;




/* Subquery Solution */

SELECT
    ROUND(
        SQRT( y_dist + x_dist )
    , 4)
FROM (
    SELECT
        POW( MAX(LAT_N) - MIN(LAT_N), 2) AS y_dist,
        POW( MAX(LONG_W) - MIN(LONG_W), 2) AS x_dist
    FROM STATION
) AS dist;