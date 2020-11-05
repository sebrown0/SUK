USE salaroo_uk;
DROP TRIGGER IF EXISTS update_loan_amount;
DELIMITER $$
CREATE TRIGGER 
	update_loan_amount 
AFTER INSERT ON 
	student_loan_deduction 
FOR EACH ROW
BEGIN	
    UPDATE 
		student_loan sl        
	SET 
		sl.current_amount = sl.current_amount - NEW.amount,
        sl.student_loan_deduction_id = NEW.id
	WHERE
		sl.loan_type = NEW.loan_type
	AND
		sl.id = NEW.student_loan_id
	AND
		sl.employee_id = NEW.student_loan_employee_id;        
END$$
DELIMITER ;

/*
-- TEST TRIGGER update_loan_amount
	SELECT max(payroll_number) INTO @payroll_num FROM payroll_run;
    
	INSERT INTO  payroll_run
		(payroll_number, tax_year_id, payroll_frequency_id) 
	VALUES 
		(@payroll_num + 1, "2020", 1);
        
INSERT INTO `salaroo_uk`.`payroll_result_deduction` 
	(`payroll_run_id`, `payroll_run_tax_year_id`, `payroll_run_payroll_frequency_id`, `employee_payroll_details_payroll_id`, `paye_tax`, `ni`, `pension`, `total`) 
VALUES 
	((SELECT max(pr.id) FROM 
	payroll_run pr
LEFT JOIN 
	payroll_frequency pf
ON
	pr.payroll_frequency_id = pf.id
WHERE
	pf.pay_frequency_id = "W1"
AND
	pf.last_payroll_run_number = 0), "2020", 1, "NI123456D", 123.45, 43.21, 0, 0);

SELECT max(prd.id) INTO @max_id FROM payroll_result_deduction prd;
SELECT sl.id INTO @student_loan_id FROM student_loan sl WHERE sl.loan_type = 2 AND sl.employee_id = "LS1";

INSERT INTO `salaroo_uk`.`student_loan_deduction` 
	(`payroll_result_deduction_id`, `amount`, `loan_type`, `student_loan_id`, `student_loan_employee_id`) 
VALUES 
	(@max_id, 50.12, 2, @student_loan_id, "LS1");
*/