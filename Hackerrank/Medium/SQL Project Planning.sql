
/*
    My Strategy:

    Since it is guaranteed every project date is valid, meaning
    it always spans 1 day and every start date must have its
    end date.

    Observe that intermediate dates always have either:
        >   Start_date occurs in End_Date
        >   End_date occurs in Start_Date

    So if I am selecting Start_Date, I exclude those Start_Date
    which occurs in End_Date. I will left with those project
    Start_Dates which is not in intermediate date.
    If I am selecting End_Date, I exclude those End_Date which
    occurs in Start_Date. I will left with those project End_Dates
    which is not in intermedate date.

    Now, If they are sorted, surely one row of Start_Date 
    corresponds to the End_Date at same row perfectly. This
    is achieved by assigning row number for the two selects,
    then joining them by row number
*/

SELECT s.start, e.end FROM (
    SELECT 
        ROW_NUMBER() OVER (
            ORDER BY Start_Date
        ) AS row_n,
        Start_Date AS start
    FROM Projects
    WHERE Start_Date NOT IN (
        SELECT End_Date FROM Projects
    )
) AS s
INNER JOIN (
    SELECT
        ROW_NUMBER() OVER (
            ORDER BY End_Date
        ) AS row_n,
        End_Date AS end
    FROM Projects
    WHERE End_Date NOT IN (
        SELECT Start_Date FROM Projects
    )
) AS e
ON s.row_n = e.row_n
ORDER BY DATE_SUB( e.end, INVERVAL TO_DAYS(s.start) DAY);





/*
    ALTERNATIVE METHOD

    Like above, we select those dates which can be only valid
    Start_Date or End_Date of a project, based on if they appear
    on another column or not.

    Then, instead of sorting and applying row number, we group
    the Start_Dates together with End_Dates which is larger
    than the Start_Dates itself only (Later you'll see why
    its important)
    Then, A Start_Date can have multiple End_Dates, thus we
    will be selecting the one which is paired with the minimum.
    That will be the valid end date for corresponding Start_Date

    Due to us selecting minimum, it is important for us to
    group the Start_Dates by End_Dates which has only date
    greater.
*/
SELECT s.Start_Date, MIN(e.End_Date)
FROM (
    SELECT Start_Date
    FROM Projects
    WHERE Start_Date NOT IN (
        SELECT End_Date From Projects
    )
) AS s,
(
    SELECT End_Date
    FROM Projects
    WHERE End_Date NOT IN (
        SELECT Start_Date FROM Projects
    )
) AS e
WHERE Start_Date < End_Date
GROUP BY Start_Date
ORDER BY DATEDIFF( MIN(e.End_Date), Start_Date ), Start_Date;