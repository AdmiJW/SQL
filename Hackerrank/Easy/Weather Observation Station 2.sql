SELECT ROUND( SUM(LAT_N), 2) AS "Sum of Latitude",
    ROUND( SUM(LONG_W), 2) AS "Sum of Longitude"
    FROM STATION;