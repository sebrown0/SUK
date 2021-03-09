CREATE DEFINER=`root`@`localhost` FUNCTION `has_emp_been_assessed`(eCode VARCHAR(20)) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	DECLARE hasBeenAssessed TINYINT DEFAULT 0;
    
	SELECT COUNT(*) 
    INTO hasBeenAssessed
    FROM employee_assessment     
    WHERE emp_pension_id = get_pension_id_for_emp_code(eCode) 
    GROUP BY emp_pension_id
    LIMIT 1;
	
    RETURN hasBeenAssessed;
END