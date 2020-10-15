
/* Nested Select Solution */
SELECT CONCAT( MAX(salary * months), " ", COUNT(*) ) FROM Employee     -- Obtain the amount of maximum earning, and the count of columns
HAVING salary * months = (                          -- Filter those employees without maximum earning 
    SELECT MAX(salary * months) FROM Employee       -- Select the max earning
)


/* Group Aggregation Solution */
SELECT salary * months AS total_earnings, COUNT(*)      -- Salary * Months will later be grouped, which is able to combine with aggregated COUNT(*)
FROM Employees
GROUP BY total_earnings                 -- Group those with same total earnings together
ORDER BY total_earnings DESC            -- So that the most earned is at top
LIMIT 1;