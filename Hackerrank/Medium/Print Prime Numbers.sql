
DELIMITER $$

CREATE PROCEDURE printPrime(
    IN n INT                    -- Takes an Input n to generate primes below or equal to n
)
BEGIN
    DECLARE res VARCHAR(10000);     -- Result string
    DECLARE num INT;                -- Number currently tested
    DECLARE sq INT;                 -- Square root of number
    DECLARE i INT;                  -- Loop indicator, divisor for tested num
    DECLARE isPrime BOOL;           -- isPrime boolean flag

    SET res = '';                   -- Initialize reslt string
    SET num = 1;                    -- Initialize first number to test, 1

    mainLoop: LOOP
        IF (num > n) THEN           -- If number exceed the limit, exit and return result
            LEAVE mainLoop;
        ELSEIF (num = 2 OR num = 3) THEN        -- Number is 2 or 3. Is Prime
            SET res = CONCAT(res, num, '&');
        ELSEIF (num > 2 AND (num % 2 <> 0) AND (num % 3 <> 0) ) THEN    -- If not divisible by 2 and 3, start testing
            SET sq = FLOOR( SQRT(num) ) + 1;                    -- Only loop until square root of it   
            SET i = 6;                                          -- Start from 6 as divisor
            SET isPrime = TRUE;
            
            determineLoop: LOOP
                IF (i > sq) THEN                        -- Exceeded the limit for divisor
                    LEAVE determineLoop;
                ELSEIF (num % (i - 1) = 0) OR (num % (i + 1) = 0) THEN      -- Failed division test
                    SET isPrime = FALSE;
                    LEAVE determineLoop;
                END IF;
                SET i = i + 6;
            END LOOP;

            IF (isPrime = 1) THEN                       -- Not triggered the boolean flag. It is prime
                SET res = CONCAT(res, num, '&');
            END IF;
        END IF;

        SET num = num + 1;              -- Next number test
    END LOOP;

    SELECT SUBSTRING( res, 1, CHAR_LENGTH(res) - 1 );           -- Remove the last ampersand sign
    -- SELECT TRIM( TRAILING '&' FROM res );                    -- ALternative method

    
END $$

DELIMITER ;

CALL printPrime(1000);