
/*
    Strategy:
    Select out a table where consists of hacker_id, name, and 
    the maximum score obtained for the same challenge.

    Then, select the id, name and the sum of scores from the
    subquery
*/

SELECT sub.id, sub.name, SUM( sub.sc )
FROM (
    SELECT h.hacker_id AS id, h.name AS name, MAX(s.score) AS sc
    FROM Hackers AS h
    INNER JOIN Submissions AS s
    ON h.hacker_id = s.hacker_id
    GROUP BY h.hacker_id, h.name, s.challenge_id
) AS sub
GROUP BY sub.id. sub.name
HAVING SUM( sub.sc ) <> 0
ORDER BY SUM(sub.sc) DESC, sub.id;

