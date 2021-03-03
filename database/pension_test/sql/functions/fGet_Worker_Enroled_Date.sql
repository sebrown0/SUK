CREATE DEFINER=`root`@`localhost` FUNCTION `get_worker_enroled_date`(empCode VARCHAR(20)) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE enrolmentDate DATE;
    
    SELECT enrolment_date INTO enrolmentDate
    FROM employee_enroled 
    WHERE employee_id = empCode;
	
    RETURN enrolmentDate;
END