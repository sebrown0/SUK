CREATE DEFINER=`root`@`localhost` FUNCTION `get_last_aeo_deduction_id`(
	taxYear VARCHAR(4),
    payFrequency VARCHAR(3),    
    payrollRunId INT,
    empPayrollId VARCHAR(45)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE r_id INT;
	SELECT 
		max(aeo_ded.id) AS last_payroll_ded_id
	INTO
		r_id	
    FROM 
		aeo_deduction aeo_ded
        INNER JOIN payroll_result_deduction prd
        ON aeo_ded.payroll_result_deduction_id = prd.id	
	WHERE 
		prd.payroll_run_id = payrollRunId
	AND
		prd.payroll_run_tax_year_id = taxYear
	AND
		prd.payroll_run_payroll_frequency_id = getFrequencyId(payFrequency, taxYear)
	AND
		prd.employee_payroll_details_payroll_id = empPayrollId;
	RETURN r_id;
END