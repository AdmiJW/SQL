
/*
    We basically have to select the pairs of X and Y from the table, in which
    there exists another pair in same table where it is Y and X

    Note: (20,20) would be counted if there is another row of (20,20)

    One way to solve is to apply row number to the table, and inner join the
    2 tables where 
        >   X in first is Y in second
        >   Y in first is X in second
        >   ID number in first is less than second (To prevent duplicate like (20,20) )
*/
SELECT s1.x, s1.y
FROM (
    SELECT ROW_NUMBER() OVER (ORDER BY x) AS r, X AS x, Y AS y
    FROM Functions
) AS s1
INNER JOIN (
    SELECT ROW_NUMBER() OVER (ORDER BY x) AS r, X AS x, Y AS y
    FROM Functions
) AS s2
ON s1.x = s2.y AND s1.y = s2.x AND s1.r < s2.r
ORDER BY s1.x, s1.y;




/*
    Another way, without applying ID number,
    is to first inner join them based on
        >   X in First is Y in second
        >   Y in First is X in second
    However, now the table may have duplicates.
    Thus, first we Group them up, and conditional select them if to be
    included or not.

    COUNT(f1.x) > 1 ---- Means When (20,20) of 2 rows are grouped, There will be
    2 rows of 20 in X column here. Deals with case X = Y
    f1.x < f1.y ---- It has to be included to exclude the duplication. Eg: (11,22)
    We have to avoid selecting (22,11) as well.
*/
SELECT f1.x, f1.y
FROM Functions AS f1
INNER JOIN Functions AS f2
ON f1.x = f2.y AND f1.y = f2.x
GROUP BY f1.x, f1.y
HAVING COUNT(f1.x) > 1 OR f1.x < f1.y
ORDER BY f1.x; 


