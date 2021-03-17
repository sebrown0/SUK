CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_emp_for_test_num`(
    IN testNum INT)
BEGIN
	SELECT 
		emp.* 
	FROM test tst
		JOIN test_data_employee emp
			ON tst.employee_payroll_id = emp.payroll_id
	WHERE 
		tst.test_num = testNum;
END