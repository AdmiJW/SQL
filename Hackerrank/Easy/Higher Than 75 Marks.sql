
SELECT Name FROM STUDENTS
WHERE
    Marks > 75
ORDER BY SUBSTR(Name, -3), ID;  -- Sort the result by the Last 3 character of Name, 
                                -- then only by ID