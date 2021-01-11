CREATE PROCEDURE `get_payroll_aeo` (
	IN taxYear VARCHAR(4),
    IN payFrequency VARCHAR(2),
    IN payrollNum INT,
    IN empPayrollId VARCHAR(45))
BEGIN
DECLARE freqId INT;
    SET freqId = getFrequencyId(payFrequency, taxYear);
	SELECT 
		pd.employee_payroll_id, 
        emp_aeo.* 
	FROM 
		salaroo_uk.payroll_aeo pay_aeo 	
	INNER JOIN 
		payroll_data pd ON 	pay_aeo.payroll_data_id = pd.id
	INNER JOIN 
		payroll_run pr ON pd.payroll_run_id = pr.id	
	INNER JOIN
		employee_aeo emp_aeo ON	pay_aeo.employee_aeo_id = emp_aeo.id		
	WHERE
		pr.payroll_number = payrollNum 
	AND 
		pr.tax_year_id = taxYear 
	AND 
		pr.payroll_frequency_id = freqId
	AND
		pd.employee_payroll_id = empPayrollId;	
END