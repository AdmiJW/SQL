


/*
    Remember the basic syntax for joins:
    >   Inner join, Left Join, Right join.
    <Join type> <Table> AS <alias>
    ON < columns to join >
*/
SELECT SUM( c.POPULATION)
FROM CITY AS c
INNER JOIN COUNTRY as country
ON c.COUNTRYCODE = country.CODE
WHERE country.CONTINENT = "Asia";


/*
    We can also not to use JOIN.
    When we call FROM like this:
    FROM <table1> <table2>
    It will form cartesian product then (Which may be space consuming), then
    only we state the conditions
*/
SELECT SUM(CITY.POPULATION) 
FROM CITY, COUNTRY
WHERE
    CITY.COUNTRYCODE = COUNTRY.CODE AND
    COUNTRY.CONTINENT = 'Asia';