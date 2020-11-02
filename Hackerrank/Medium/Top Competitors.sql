
/* ======================
    FULL JOIN SOLUTION
======================= */
SELECT h.hacker_id, h.name
    FROM Hackers AS h
    INNER JOIN
        Submissions AS s
    ON
        h.hacker_id = s.hacker_id
    INNER JOIN
        Challenges AS c
    ON
        s.challenge_id = c.challenge_id
    INNER JOIN
        Difficulty AS d
    ON
        c.difficulty_level = d.difficulty_level
    WHERE
        s.score = d.score
    GROUP BY h.hacker_id, h.name        --FIrst it will group by h.hacker_id, then within each group it will
    HAVING COUNT(h.hacker_id) > 1       --Group by h.name
    ORDER BY COUNT(h.hacker_id) DESC, h.hacker_id;





