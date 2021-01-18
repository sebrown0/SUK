CREATE DEFINER = CURRENT_USER TRIGGER `salaroo_uk`.`payroll_result_deduction_AFTER_INSERT` AFTER INSERT ON `payroll_result_deduction` FOR EACH ROW
BEGIN
	DECLARE oldTax DECIMAL(10,2) DEFAULT 0;	
    DECLARE oldNi DECIMAL(10,2) DEFAULT 0; 
    DECLARE oldPension DECIMAL(10,2) DEFAULT 0;
    DECLARE oldAeoTotal DECIMAL(10,2) DEFAULT 0;
    DECLARE oldStudentLoanTotal DECIMAL(10,2) DEFAULT 0;
    
    SELECT 
		tax, ni, pension, aeo, student_loan
	INTO 
		oldTax, oldNi, oldPension, oldAeoTotal, oldStudentLoanTotal
	FROM 
		payroll_deduction_ytd    
	WHERE
		payroll_run_tax_year_id = NEW.payroll_run_tax_year_id
	AND
		payroll_run_payroll_frequency_id = NEW.payroll_run_payroll_frequency_id
	AND
        employee_payroll_id = NEW.employee_payroll_details_payroll_id;
        
	INSERT INTO payroll_deduction_ytd (
		`payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_id`, 
        `tax`, `ni`, `pension`, `aeo`, `student_loan`) 
	VALUES (
		NEW.payroll_run_tax_year_id, 
        NEW.payroll_run_payroll_frequency_id, 
        NEW.employee_payroll_details_payroll_id, 
		NEW.paye_tax + oldTax,         
        NEW.ni + oldNi,        
        NEW.pension + oldPension,         
        NEW.aeo_total + oldAeoTotal,        
        NEW.student_loan_total + oldStudentLoanTotal
        )
	ON DUPLICATE KEY UPDATE
		tax = NEW.paye_tax + oldTax,         
        ni = NEW.ni + oldNi, 
        pension = NEW.pension + oldPension,   
        aeo = NEW.aeo_total + oldAeoTotal,        
        student_loan = NEW.student_loan_total + oldStudentLoanTotal;
END