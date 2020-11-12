-- Get the Student Loans from the Payroll Data tables.
DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS get_payroll_student_loans $$
CREATE PROCEDURE get_payroll_student_loans (
	IN taxYear VARCHAR(4),
    IN payFrequencyId INT,
    IN payrollNum INT)
BEGIN	
	SELECT 
		pd.employee_payroll_id, pd.payroll_run_id, 		
		psl.amount, psl.loan_type, psl.student_loan_id,
        sl.start_date, sl.original_amount, sl.loan_type, sl.current_amount
	FROM 
		payroll_data pd
		LEFT JOIN payroll_run pr ON pd.payroll_run_id = pr.id		
		INNER JOIN payroll_student_loan psl ON pd.ID = psl.payroll_data_id
        LEFT JOIN student_loan sl ON psl.student_loan_id = sl.id		
	WHERE		
		pr.payroll_number = payrollNum AND pr.tax_year_id = taxYear AND pr.payroll_frequency_id = payFrequencyId;    
END $$
DELIMITER ;