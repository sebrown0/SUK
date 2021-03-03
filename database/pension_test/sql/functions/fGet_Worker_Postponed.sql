CREATE DEFINER=`root`@`localhost` FUNCTION `get_worker_postponed`(empPensionId VARCHAR(40)) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	DECLARE isPostponed TINYINT;
    
    SELECT is_postponed INTO isPostponed
    FROM employee_postponement
	WHERE emp_pension_id = empPensionId;
	
    IF isPostponed IS NULL 
		THEN SET isPostponed = 0;
    END IF;
    
    RETURN isPostponed;
END