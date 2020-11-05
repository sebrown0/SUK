USE salaroo_uk;
DROP FUNCTION IF EXISTS getLoanForEmp;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getLoanForEmp`(emp_id VARCHAR(3), loan_id INT) RETURNS DECIMAL(7,2)
    DETERMINISTIC
BEGIN
	DECLARE loan_amount DECIMAL(7,2);
	SELECT current_amount INTO loan_amount FROM salaroo_uk.student_loan WHERE employee_id = emp_id AND loan_type = loan_id;

RETURN loan_amount;
END$$
DELIMITER ;