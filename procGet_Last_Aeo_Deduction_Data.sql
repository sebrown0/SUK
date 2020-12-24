CREATE DEFINER=`root`@`localhost` PROCEDURE `get_last_aeo_deduction_data`(
	IN taxYear VARCHAR(4),
    IN payFrequency VARCHAR(3),    
    IN payrollRunId INT,
    IN empPayrollId VARCHAR(45))
BEGIN
	SELECT 
		aeo_ded.id AS last_payroll_ded_id, aeo_ded.amount_deducted, 
        aeo_ded.amount_carried_forward, aeo_ded.cumulative_carried_forward, aeo_ded.ytd	
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
		prd.employee_payroll_details_payroll_id = empPayrollId
	AND
		aeo_ded.id = get_last_aeo_deduction_id(taxYear, payFrequency, payrollRunId, empPayrollId);
END