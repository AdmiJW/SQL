
/*
    It is very convenient that the NULL entries are grade 8 and below,
    since we have to sort by grades as priority, all NULL values by default
    will already be at bottom.
*/

-- CASE... WHEN & JOIN SOLUTION
SELECT (
    CASE
        WHEN grade.Grade < 8 THEN NULL
        ELSE stud.Name
    END
), grade.Grade, stud.Marks
FROM Students AS stud
INNER JOIN Grades AS grade
ON stud.Marks BETWEEN grade.Min_Mark AND grade.Max_Mark
ORDER BY grade.Grade DESC, stud.Name, stud.Marks;


-- IF( Condition, ifTrue, ifFalse) & JOIN SOLUTION
SELECT 
    IF (grade.Grade < 8, NULL, stud.Name) , grade.Grade, stud.Marks
FROM Students AS stud
INNER JOIN Grades AS grade
ON stud.Marks BETWEEN grade.Min_Mark AND grade.Max_Mark
ORDER BY grade.Grade DESC, stud.Name, stud.Marks;


-- UNION SOLUTION
(
    SELECT stud.Name AS name, grades.Grade AS grade, stud.Marks AS mark
    FROM Students AS stud
    INNER JOIN Grades AS grades
    ON stud.Marks BETWEEN grades.Min_Mark AND grades.Max_Mark
    WHERE grades.Grade >= 8
) UNION ALL (
    SELECT NULL AS name, grades.Grade AS grades , stud.Marks AS mark
    FROM Students AS stud
    INNER JOIN Grades AS grades
    ON stud.Marks BETWEEN grades.Min_Mark AND grades.Max_Mark
    WHERE grades.Grade < 8
)
ORDER BY grade DESC, name, mark;