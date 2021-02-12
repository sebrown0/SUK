CREATE DEFINER=`root`@`localhost` PROCEDURE `get_basic_and_gross_for_emp`(
	IN taxYear VARCHAR(4),
    IN payFrequency VARCHAR(2),
    IN payrollNum INT,
    IN empPayrollId VARCHAR(45))
BEGIN
	DECLARE freqId INT;
    SET freqId = getFrequencyId(payFrequency, taxYear);
    SELECT 
		pd.id as payroll_data_id, pd.employee_payroll_id, pd.payroll_run_id, 
		pb.hours_worked, pb.rate, pb.total, pb.units,
		pg.bonus, pg.commision, pg.overtime, pg.total_gross		
	FROM 
		payroll_data pd
		LEFT JOIN payroll_run pr ON pd.payroll_run_id = pr.id
			LEFT JOIN payroll_basic pb ON pd.ID = pb.payroll_data_id				
				LEFT JOIN payroll_gross pg ON pd.ID = pg.payroll_data_id
	WHERE
		pr.payroll_number = payrollNum 
	AND 
		pr.tax_year_id = taxYear 
	AND 
		pr.payroll_frequency_id = freqId
	AND
		pd.employee_payroll_id = empPayrollId;
END