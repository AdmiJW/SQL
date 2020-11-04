



SELECT w.id, wp.age, w.coins_needed, w.power
FROM
    Wands AS w
INNER JOIN
    Wands_Property AS wp
ON
    w.code = wp.code
INNER JOIN (
    SELECT w.code AS code, w.power AS pow, MIN(w.coins_needed) AS coins         --Subquery which returns minimum cost for each code (age) and power
    FROM 
        Wands AS w
    INNER JOIN
        Wands_Property AS wp
    ON
        w.code = wp.code
    WHERE wp.is_evil = 0
    GROUP BY w.code, w.power
) AS subquery
ON
    w.code = subquery.code AND              -- For each row, ensure that first the code and power is same as in subquery, and it is minimum wand
    w.power = subquery.pow AND
    w.coins_needed = subquery.coins
ORDER BY
    w.power DESC, wp.age DESC;