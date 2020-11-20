
/*------------------
USING STORED PROCEDURES
---------------------*/
DELIMITER $$

CREATE PROCEDURE DrawTriangle()
BEGIN

    DECLARE x INT;
    DECLARE str VARCHAR(255);

    SET x = 0;
    SET str = '*';

    printer: LOOP
        IF x >= 20 THEN
            LEAVE printer;
        ELSE
            SELECT str;
            SET str = CONCAT(str,' *');
        END IF;

        SET x = x + 1;
    END LOOP; 

END $$

DELIMITER ;

CALL DrawTriangle();




/*-------------------------
METHOD USING Variables, dummy table and Repeat
---------------------------*/
SET @p = 0;
SELECT REPEAT('* ', @p := @p + 1) FROM information_schema.tables
LIMIT 20;