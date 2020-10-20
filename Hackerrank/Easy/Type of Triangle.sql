
/*
    When we want to perform conditional checking like IF ELSE does, in this case we'll be
    using the CASE ... WHEN ... THEN ... ELSE syntax for that. For more information see
    CASE documentation

    For a function that evaluates the maximum and minimum out of arguments, we cannot use MAX
    or MIN because it is aggregate function. Instead use GREATEST() or LEAST() for that
*/


SELECT
    CASE
        WHEN A + B + C - GREATEST(A,B,C) <= GREATEST(A,B,C) THEN "Not A Triangle"
        WHEN A = B AND B = C THEN "Equilateral"
        WHEN A = B OR B = C OR A = C THEN "Isosceles"
        ELSE "Scalene"
    END AS "Type of Triangle"
FROM TRIANGLES;