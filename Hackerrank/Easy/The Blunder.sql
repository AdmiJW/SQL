
SELECT
CEIL(                   -- For some reason Hackerrank wants it Ceiling
    AVG( Salary )       --The real average value, with no 0 replaced
    -
    AVG ( CONVERT( REPLACE( CAST( Salary AS CHAR ) , '0', '') , SIGNED) )   -- Cast Salary to String, Replace all 0 with '', 
                                                                            -- Convert back to int, Get average
) AS 'Miscalculated'
FROM EMPLOYEES;