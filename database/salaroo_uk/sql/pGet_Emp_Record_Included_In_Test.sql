CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_record_included_in_test`(IN testNum INT)
BEGIN
	-- Get the fields needed to create a record for the employee in the test run.
    -- --------------------------------------------------------------------------
    
 	SELECT 
		e.*, s.*, e.payroll_id AS ni_number
	FROM 
		test t 
		JOIN test_data_employee e ON e.payroll_id = t.employee_payroll_id
			JOIN test_data_salary s ON s.salary_test_num = t.salary_test_num
	WHERE 
		t.test_num = testNum;
END