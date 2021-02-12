CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_student_loans`(
	IN taxYear VARCHAR(4),
    IN payFrequency VARCHAR(3),
    IN payrollNum INT,
    IN empPayrollId VARCHAR(45))
BEGIN
DECLARE freqId INT;
    SET freqId = getFrequencyId(payFrequency, taxYear);
	SELECT 
		pd.employee_payroll_id, pd.payroll_run_id, 			
        sl.start_date, sl.original_amount, sl.loan_type, 
        sl.current_amount, sl.reason_for_deduction, sl.stop_notice_received,
        (SELECT DISTINCT getEmpId_ForPayrollId(empPayrollId)) as employee_id,
        psl.student_loan_id
	FROM 
		payroll_data pd
		LEFT JOIN payroll_run pr ON pd.payroll_run_id = pr.id		
		INNER JOIN payroll_student_loan psl ON pd.ID = psl.payroll_data_id
        LEFT JOIN student_loan sl ON psl.student_loan_id = sl.id		
	WHERE		
		pr.payroll_number = payrollNum 
	AND 
		pr.tax_year_id = taxYear 
	AND 
		pr.payroll_frequency_id = freqId
	AND
		pd.employee_payroll_id = empPayrollId;	
END