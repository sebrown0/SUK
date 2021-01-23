CREATE DEFINER=`root`@`localhost` FUNCTION `get_emp_avg_hours_week`(payrollId VARCHAR(25)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE avgHours DECIMAL(5,2);
    
	SELECT avg_hours_per_week INTO avgHours
    FROM salaroo_uk.employee_payroll_details
    WHERE payroll_id = payrollId;
	
    RETURN avgHours;
END