CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_info`(IN testNum INT)
BEGIN
	SELECT 
		test_num , (SELECT str_to_date(test_date, "%d/%m/%Y")) AS test_date, event_type,
        pension_scheme_id, employee_pension_id, employee_id, emp_payroll_id, 
		prp_tax_year, prp_pay_frequency,
        assessment_reason 
	FROM 
		temp_test_data
	WHERE 
		test_num = testNum;
END