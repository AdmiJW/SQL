

/*
    The strategy goes as follows:
    >   Since we want to output the hackers that are either
            -   Having maximum count of submissions
            -   Is the only distinct count of submissions. In other words, no other hacker has same submission count as this hacker

    Thus, we deal with each case one by one.
    >   For the distinct count of submissions, we select all the available hacker submission counts first. Then, using that subquery we
        group those frequencies together, and output those who has the count of frequency only occurring ONCE.
    >   For the maximum count, we select all the available hacker submission counts first. Then, using that subquery we find the
        count that is maximum
    
    >   Now we have a table which consists of counts of submission that either is maximum out of all counts, or only occurred once.
        Either way, we can now filter those rows so that only those ones which frequencies in the previous table are shown.
*/



SELECT h.hacker_id, h.name, COUNT(*)
FROM Hackers AS h
INNER JOIN Challenges AS c
ON h.hacker_id = c.hacker_id
GROUP BY h.hacker_id, h.name
HAVING COUNT(*) IN (                --Select the rows which number of submissions inside:
    SELECT freqTab.freq
    FROM (
        SELECT COUNT(*) AS freq         --Find the frequencies
        FROM Hackers AS h
        INNER JOIN Challenges AS c
        ON c.hacker_id = h.hacker_id
        GROUP BY h.hacker_id
    ) AS freqTab
    GROUP BY freqTab.freq               --Group those frequencies together
    HAVING COUNT(*) = 1                 --Which frequency is only once
    UNION                               --Combine the result with
    SELECT MAX(maxTab.freq)             --The maximum frequency
    FROM (
        SELECT COUNT(*) AS freq
        FROM Hackers AS h
        INNER JOIN Challenges AS c
        ON c.hacker_id = h.hacker_id
        GROUP BY h.hacker_id
    ) AS maxTab
)
ORDER BY COUNT(*) DESC, h.hacker_id;            --Order by descending frequency, then hacker id
