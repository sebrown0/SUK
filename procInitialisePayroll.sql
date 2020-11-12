DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS initialise_payroll $$
CREATE PROCEDURE initialise_payroll (IN employer_tax_year VARCHAR(4))
BEGIN	
    SET foreign_key_checks = 0;
    
    CALL create_payroll_dates(employer_tax_year);

	-- Payroll Frequency
	DELETE FROM payroll_frequency WHERE id !='' AND tax_year_id = employer_tax_year;
	INSERT INTO  payroll_frequency
		(id, tax_year_id, pay_frequency_id, last_payroll_run_number)
	Values
		(1, employer_tax_year, "W1", 0),
		(2, employer_tax_year, "W2", 0),
		(3, employer_tax_year, "W4", 0),
		(4, employer_tax_year, "M1", 0),
		(5, employer_tax_year, "M3", 0),
		(6, employer_tax_year, "M6", 0),
		(7, employer_tax_year, "MA", 0),
		(8, employer_tax_year, "IO", 0),
		(9, employer_tax_year, "IR", 0);
		
END$$
DELIMITER ;
    
    /*  
	-- Payroll Run    
	DELETE FROM payroll_run WHERE id !='' AND tax_year_id = employer_tax_year;
	INSERT INTO  payroll_run
		(payroll_number, tax_year_id, payroll_frequency_id, payroll_dates_id)
	Values
		(1, employer_tax_year, 1, getPayrollDateId_ForPayrollNum("W1",employer_tax_year,1)),
		(1, employer_tax_year, 4, getPayrollDateId_ForPayrollNum("M1",employer_tax_year,1));

	-- Employee Payroll Result
	DELETE FROM `employee_payroll_result` WHERE id !='';
	INSERT INTO `employee_payroll_result`
		(`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_details_payroll_id`, `gross_pay`, `basic_pay`, `net_pay`, `bonus`)
	Values
		((SELECT pr.id FROM
		payroll_run pr
	  Left Join
		payroll_frequency pf
	  ON
		pr.payroll_frequency_id = pf.Id
	  WHERE
		pf.pay_frequency_id = "W1"
	  AND
		pf.last_payroll_run_number = 0), employer_tax_year, 1, "NI123456D", 1200, 1000, 800, 0);
			
	-- Payroll Result Deduction
	DELETE FROM `payroll_result_deduction` WHERE id != '';    
	INSERT INTO `payroll_result_deduction`
		(`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_details_payroll_id`, `paye_tax`, `ni`, `pension`, `total`)
	  Values
		((SELECT pr.id FROM
		payroll_run pr
	  Left Join
		payroll_frequency pf
	  ON
		pr.payroll_frequency_id = pf.Id
	  WHERE
		pf.pay_frequency_id = "W1"
	  AND
		pf.last_payroll_run_number = 0), employer_tax_year, 1, "NI123456D", 123.45, 43.21, 0, 0);
	  
	-- Student Loan Deduction
	DELETE FROM `salaroo_uk`.`student_loan_deduction` WHERE id != '';
		
	SELECT max(prd.id) INTO @max_id FROM payroll_result_deduction prd;
	SELECT sl.id INTO @student_loan_id FROM student_loan sl WHERE sl.loan_type = 1 AND sl.employee_id = "LS1";
		
	INSERT INTO `salaroo_uk`.`student_loan_deduction`
		(`payroll_result_deduction_id`, `amount`, `loan_type`, `student_loan_id`, `student_loan_employee_id`)
	Values
		(@max_id, 50.12, 1, @student_loan_id, "LS1");
	
    */