CREATE DEFINER=`root`@`localhost` FUNCTION `get_worker_enroled`(empCode VARCHAR(20)) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	DECLARE isEnroled TINYINT;
    
    SELECT is_enroled INTO isEnroled
    FROM employee_enroled 
    WHERE employee_id = empCode;
	
    IF isEnroled IS NULL 
		THEN SET isEnroled = 0;
    END IF;
    
    RETURN isEnroled;
END