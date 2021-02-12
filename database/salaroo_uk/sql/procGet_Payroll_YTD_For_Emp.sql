CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_ytd_for_emp`(
	IN taxYear VARCHAR(4),
    IN payFrequency VARCHAR(3),
    IN empPayrollId VARCHAR(45))
BEGIN
	DECLARE freqId INT;
    SET freqId = getFrequencyId(payFrequency, taxYear);
    
	SELECT  
		ded.id AS deduction_id,
		ded.payroll_run_tax_year_id, ded.payroll_run_payroll_frequency_id, 
        ded.employee_payroll_id, ded.tax, ded.ni, ded.pension, ded.aeo, ded.student_loan,
		pay.id AS payment_id,
		pay.gross_pay, pay.basic_pay, pay.net_pay, pay.bonus, pay.commission, 
        pay.overtime, pay.pension, pay.expenses
	FROM 
		payroll_deduction_ytd ded
		INNER JOIN payroll_payment_ytd pay 
			ON 
				ded.payroll_run_tax_year_id = pay.payroll_run_tax_year_id 
			AND 
				ded.payroll_run_payroll_frequency_id = pay.payroll_run_payroll_frequency_id 
			AND  
				ded.employee_payroll_id = pay.employee_payroll_id    
	WHERE
		ded.payroll_run_tax_year_id = taxYear 
	AND 
		ded.payroll_run_payroll_frequency_id = freqId
	AND
		ded.employee_payroll_id = empPayrollId; 
END