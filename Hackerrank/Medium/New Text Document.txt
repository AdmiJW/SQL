/*
    What we basically need to do is:
    Combine two subquery results into one unified query result, using UNION
    In the first query result, sort by Name
    In the second query result, sort by the count of profession, then by the profession name

    At first we might attempt to just put ORDER BY in each of the subqueries. Unfortunately,
    ORDER BY don't work in subqueries, so the only way we can sort is to sort the UNIFIED table.
    However, each subquery will have different column to sort, how do we achieve that?

    One solution is that in the subquery, we put additional columns which isn't the data that
    we want, but is the determining element in sorting.
    For example, the sorter in subquery 1 (By name) is the name itself, and the sorter in 
    subquery 2 is the number count of occupations.

    We use UNION ALL instead of UNION alone to allow duplicate values, especially for subquery
    where there can be multiple same frequency professions.

    In the derived table, it must be given a alias else it will throw an error. We will sort
    the unified table first by the ord (First query - 0, Second Query - 1), and then only by the
    sorter value.
*/


SELECT Val FROM (
    (SELECT 
        0 AS "Ord",
        CONCAT(Name, "(", LEFT(Occupation, 1), ")" ) AS "Val",
        LEFT(Name, 1) AS "Sorter"
    FROM OCCUPATIONS)
    UNION ALL
    (SELECT
        1 AS "Ord",
        CONCAT("There are a total of ", COUNT(Occupation), " ", LOWER(Occupation), "s." ) AS "Val",
        COUNT(Occupation) AS "Sorter"
     FROM OCCUPATIONS
     GROUP BY Occupation
    )
    
) AS T1
ORDER BY Ord, Sorter, Val;