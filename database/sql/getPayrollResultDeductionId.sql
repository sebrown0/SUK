CREATE DEFINER=`root`@`localhost` FUNCTION `get_payroll_result_deduction_id`(
	taxYear VARCHAR(4),
    payFrequency VARCHAR(3),    
    payrollRunId INT,
    empPayrollId VARCHAR(45)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE r_id INT;
	SELECT 
		id 
	INTO
		r_id
	FROM 
		payroll_result_deduction 
	WHERE 
		payroll_run_id = payrollRunId
	AND
		payroll_run_tax_year_id = taxYear
	AND
		payroll_run_payroll_frequency_id = getFrequencyId(payFrequency, taxYear)
	AND
		employee_payroll_details_payroll_id = empPayrollId;
	RETURN r_id;
END