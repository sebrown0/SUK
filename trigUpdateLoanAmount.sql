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
		sl.current_amount = sl.current_amount - NEW.amount
        -- sl.student_loan_deduction_id = NEW.id
	WHERE
		sl.loan_type = NEW.loan_type
	AND
		sl.id = NEW.student_loan_id
	AND
		sl.employee_id = NEW.student_loan_employee_id;        
END$$
DELIMITER ;