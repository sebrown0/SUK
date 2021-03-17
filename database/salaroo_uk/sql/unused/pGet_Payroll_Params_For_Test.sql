CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_params_for_test`(IN testNum INT)
BEGIN
	SELECT 
		params.* 
	FROM 
		test_data_payroll_params params
		JOIN test t ON t.payroll_params_test_num = params.payroll_params_test_num
	WHERE t.test_num = testNum;
END