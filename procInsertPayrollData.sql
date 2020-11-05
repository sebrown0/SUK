DELIMITER //
USE salaroo_uk //
DROP PROCEDURE IF EXISTS `insert_payroll_data` //
CREATE PROCEDURE insert_payroll_data (IN pay_id VARCHAR(14), IN basic_units INT, IN freq_id VARCHAR(3), IN tax_yr VARCHAR(4))
BEGIN	
	DECLARE salary_type VARCHAR(2);    
    DECLARE basic_amount DECIMAL(8,2);    
    DECLARE emp_rate DECIMAL(10,2);
    DECLARE bDone INT;
    DECLARE loan_amount DECIMAL(9,2);
    DECLARE the_loan_type ENUM('1', '2', '3');
    DECLARE payroll_data_id INT;
    
    DECLARE loan_cursor CURSOR FOR SELECT loan_type, current_amount FROM student_loan WHERE employee_id =  getEmpId_ForPayrollId(pay_id);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET bDone=1;
    
    -- Insert the data
    INSERT INTO `payroll_data` (`payroll_run_id`, `employee_payroll_id`, `commission`) VALUES (getPayrollRunId(freq_id, tax_yr), pay_id, 0);
            
	-- Get the id to use in the child tables, i.e. employee_basic
	SELECT max(id) INTO payroll_data_id FROM payroll_data;
	
    -- Insert employee basic
    SET salary_type = getEmpType_ForPayrollId(pay_id);
    -- SELECT rate INTO basic_rate FROM employee_basic WHERE employee_payroll_details_payroll_id = pay_id;
    SELECT rate_of_pay INTO emp_rate FROM employee_payroll_details WHERE payroll_id = pay_id;
    
    IF salary_type = 'V' THEN
		SET basic_amount = emp_rate * basic_units;
	ELSE
    	SET basic_amount = emp_rate;
    END IF;
    
    INSERT INTO employee_basic (`payroll_data_id`, `units`, `rate`, `total`) VALUES (payroll_data_id, basic_units, emp_rate, basic_amount);
    
    -- Insert a row for each loan
    OPEN loan_cursor;
    SET bDone = 0;
    read_loan_loop: LOOP
		FETCH loan_cursor INTO the_loan_type, loan_amount;
        IF bDone THEN
			LEAVE read_loan_loop;
		END IF;
        INSERT INTO payroll_student_loan (`payroll_data_id`, `loan_type`, `amount`) VALUES (payroll_data_id, the_loan_type, loan_amount); 
	END LOOP;
    CLOSE loan_cursor;
    
    -- Insert a row for each AEO
    -- etc, etc.........
END//
DELIMITER ;