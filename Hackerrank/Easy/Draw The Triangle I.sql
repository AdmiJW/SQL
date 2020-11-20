
/*
    Welcome to a more programming part of SQL: Stored Procedures
*/
DELIMITER $$

CREATE PROCEDURE LoopDemo()
BEGIN
    DECLARE x INT;
    DECLARE str VARCHAR(255);

    SET x = 0;
    SET str = '';

    initializeStr: LOOP
        IF x < 20 THEN
            SET str = CONCAT(str, '* ');
        ELSE
            LEAVE initializeStr;
        END IF;
        
        SET x = x + 1;
    END LOOP;

    printLoop: LOOP
        IF x > 0 THEN
            SELECT str;
        ELSE
            LEAVE printLoop;
        END IF;
        
        SET str = SUBSTR(str, 1, LENGTH(str) - 2 );
        SET x = x - 1;
    END LOOP;

END $$

DELIMITER ;

CALL LoopDemo();






/*--------------------------
THere is actually a alternative trick:
Using Repeat and dummy table along with variable to generate
the pattern
-----------------------------*/
SET @p = 21;
SELECT REPEAT('* ', @p := @p - 1) FROM information_schema.tables
LIMIT 20;