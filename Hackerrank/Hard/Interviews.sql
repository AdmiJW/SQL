









SELECT
    con.contest_id,
    con.hacker_id,
    con.name,
    SUM( stat.ts ),
    SUM( stat.tas ),
    SUM( stat.cv ),
    SUM( stat.cuv )
FROM Contests AS con
INNER JOIN Colleges as col
ON con.contest_id = col.contest_id
INNER JOIN (

    -- This subquery connects Challenges table with the View_Stats and Submission_Stats table.
    -- Since there may be challenge id not present in View_Stats or Submission_Stats, LEFT JOIn is used
    -- Also, there can be multiple challenge_id for one college_id. Grouping by college_Id is required
    SELECT
        ch.college_id AS cid,
        SUM( v.cv ) AS cv,
        SUM( v.cuv ) AS cuv,
        SUM( s.ts ) AS ts,
        SUM( s.tas ) AS tas
    FROM
        Challenges AS ch
    LEFT JOIN (

        -- Group the challenge ID in the View_Stats Table
        SELECT
            v.challenge_id AS cid,
            SUM( v.total_views ) AS cv,
            SUM( v.total_unique_views ) AS cuv
        FROM
            View_Stats AS v
        GROUP BY cid
        -------------------------------------------------

    ) AS v
    ON v.cid = ch.challenge_id
    LEFT JOIN (

        -- Group the challenge ID in the Submission_Stats Table
        SELECT
            s.challenge_id AS cid,
            SUM( s.total_submissions ) AS ts,
            SUM( s.total_accepted_submissions ) AS tas
        FROM
            Submission_Stats AS s
        GROUP BY cid
        -------------------------------------------------

    ) AS s
    ON s.cid = ch.challenge_id
    GROUP BY cid
    -------------------------------------------------------

) AS stat
ON stat.cid = col.college_id
GROUP BY con.contest_id, con.hacker_id, con.name
ORDER BY con.contest_id;