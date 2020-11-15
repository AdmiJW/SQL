


/* FINAL SOLUTION - LENGTHY, NOT OPTIMIZED, BUT GETS THE WORK DONE :( 
    THE PROBLEM SO HARD    
 */

SELECT
    a.day,
    b.max,
    a.id,
    a.name
FROM ( 

    --  Having the ID of hackers which submitted maximum submission on each day, join them with their name
    SELECT
        max_id.day AS day,
        max_id.id AS id,
        Hackers.name AS name
    FROM (

        --  Select the day, and the minimum of the ID of hacker which had the maximum submission count on that particular day
        SELECT
            freq.day AS day,
            MIN( freq.id ) AS id
        FROM (

            -- Select submission_date and hacker_id, and aggregate COUNT to show how many submissions this hacker done in
            -- that day
            SELECT
                submission_date AS day,
                hacker_id AS id,
                COUNT( hacker_id ) AS cnt
            FROM Submissions
            GROUP BY day, id

        ) AS freq
        INNER JOIN (

            -- Selects the maximum count of submission on that day
            SELECT
                freq.day AS day,
                MAX( freq.cnt ) AS max
            FROM (

                -- Select submission_date and hacker_id, and aggregate COUNT to show how many submissions this hacker done in
                -- that day
                SELECT
                    submission_date AS day,
                    hacker_id AS id,
                    COUNT( hacker_id ) AS cnt
                FROM Submissions
                GROUP BY day, id

            ) AS freq
            GROUP BY freq.day

        ) AS maximums
        ON freq.day = maximums.day AND freq.cnt = maximums.max          -- Select the row where days equal, and it is maximum submission
        GROUP BY freq.day                                               -- by this hacker

    ) AS max_id
    INNER JOIN Hackers 
    ON Hackers.hacker_id = max_id.id

) AS a
INNER JOIN (

    -- Now this block will reduce each day to pair with a aggregate COUNT which counts how many person is submitting on today and previous
    -- days nonstop so far
    SELECT
        consistent.day AS day,
        COUNT( consistent.id ) AS cnt
    FROM (

        --  This block selects each date along with hacker_id(s) which up until current date, the hacker is on the streak of submission
        --  Meaning no absence in submitting before
        SELECT
            s.submission_date AS day,
            s.hacker_id AS id
        FROM Submissions AS s
        INNER JOIN (

            -- This block selects hacker_id, and submission_date pair with a COUNT column showing how many submissions on previous days
            -- and current day summed up
            SELECT
                s.id AS id,
                s.day AS day,
                COUNT( uniq.day ) AS dayCnt
            FROM (

                -- This block only shows all combinations of hacker_id and submission_date pairs. If it exist, the hacker does submit
                SELECT
                    hacker_id AS id, submission_date AS day 
                FROM Submissions
                GROUP BY hacker_id, submission_date

            ) AS s
            INNER JOIN (

                -- This block only shows all combinations of hacker_id and submission_date pairs. If it exist, the hacker does submit
                SELECT
                    hacker_id AS id, submission_date AS day 
                FROM Submissions
                GROUP BY hacker_id, submission_date

            ) AS uniq
            ON s.id = uniq.id AND s.day >= uniq.day         -- Join A.date with B.date(s) where A.date is greater than B.date. So that it can
            GROUP BY s.id, s.day                            -- be counted

        ) AS cum
        ON s.submission_date = cum.day AND s.hacker_id = cum.id AND
            cum.dayCnt = DATEDIFF( s.submission_date , (            -- Count of submission on that day, is equal to date difference of current
                SELECT MIN(submission_date)                         -- day and start date, + 1
                FROM Submissions
            ) ) + 1
        GROUP BY s.submission_date, s.hacker_id
    ) AS consistent
    GROUP BY consistent.day

) AS b
ON a.day = b.day
ORDER BY a.day;