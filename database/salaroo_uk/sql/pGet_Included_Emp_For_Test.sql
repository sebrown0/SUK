CREATE DEFINER=`root`@`localhost` PROCEDURE `get_included_emp_for_test`(
	IN testNum INT)
BEGIN
	SELECT 
		p.emp_payroll_id 
	FROM 
		test_data_payroll_params p 			
		INNER JOIN test t 
		ON t.payroll_params_test_num = p.payroll_params_test_num
	WHERE t.test_num = testNum; 
END