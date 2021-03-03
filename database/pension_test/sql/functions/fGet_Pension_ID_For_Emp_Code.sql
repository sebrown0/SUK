CREATE DEFINER=`root`@`localhost` FUNCTION `get_pension_id_for_emp_code`(eCode VARCHAR(20)) RETURNS varchar(40) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE penId VARCHAR(40);
    
	SELECT employee_pension_id INTO penId
    FROM employee_pension
	WHERE employee_id = eCode LIMIT 1;
	
    RETURN penId;
END