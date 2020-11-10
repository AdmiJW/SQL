

/*
    We basically have to obtain the table which contains all information in one:
    >   Student ID
    >   Student Name        //Return value
    >   Friend ID
    >   Student Salary
    >   Friend Salary

    What inner join does is just add the columns of the said table into current table, when
    the condition satisfies for both table. Therefore, we just have to combine tables.
*/

SELECT s.name FROM Students AS s
INNER JOIN Friends as f
ON s.ID = f.ID
INNER JOIN Packages as p
ON s.ID = p.ID
INNER JOIN Packages as p2
on f.Friend_ID = p2.ID
WHERE p2.salary > p.salary
ORDER BY p2.salary;