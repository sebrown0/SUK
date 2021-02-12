CREATE DEFINER=`root`@`localhost` FUNCTION `get_next_emp_aeo_id`() RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE nextId INT;    
    SELECT MAX(id)+1 INTO nextId FROM employee_aeo;
	RETURN nextId;
END