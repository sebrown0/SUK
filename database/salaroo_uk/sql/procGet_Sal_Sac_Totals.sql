CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sal_sac_totals`(
	IN empPayrollId VARCHAR(45),
    INOUT pensionTotal DECIMAL(10,2),
    INOUT otherTotal DECIMAL(10,2))
BEGIN
	-- -------------------------------------------
    -- Get the salary sacrifice totals for pension 
    -- and all other schemes for an employee.
    -- -------------------------------------------
	
    SELECT SUM(sacrifice_amount) INTO pensionTotal    
	FROM salaroo_uk.employee_salary_sacrifice emp_sac			
	WHERE employee_payroll_id = empPayrollId AND salary_sacrifice_scheme_num <= 2
	GROUP BY sacrifice_amount;
    
	SELECT SUM(sacrifice_amount) INTO otherTotal    
	FROM salaroo_uk.employee_salary_sacrifice emp_sac			
	WHERE employee_payroll_id = empPayrollId AND salary_sacrifice_scheme_num > 2
	GROUP BY sacrifice_amount;
END