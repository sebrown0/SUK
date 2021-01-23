CREATE DEFINER=`root`@`localhost` FUNCTION `get_emp_rate_of_pay`(payrollId VARCHAR(25)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE rop DECIMAL(9,2);
    
	SELECT rate_of_pay INTO rop
    FROM salaroo_uk.employee_payroll_details
    WHERE payroll_id = payrollId;

	RETURN rop;
END