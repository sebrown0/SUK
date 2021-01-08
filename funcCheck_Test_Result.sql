CREATE DEFINER=`root`@`localhost` FUNCTION `check_test_result`(testNum INT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
	DECLARE passOrFail BOOLEAN;
    DECLARE numRecords INT;
    SELECT COUNT(*) AS num INTO numRecords from (SELECT  
		expected.expected_test_num,
		expected.gross, expected.net, expected.tax, expected.employee_ni, expected.employer_ni, 
		expected.employee_pension, expected.salary_sacrifice, expected.employer_pension, 
		expected.loan_1_deduction, expected.loan_2_deduction, expected.loan_3_deduction, expected.total_loan_deduction, 
		expected.aeo_1_deduction, expected.aeo_2_deduction, expected.aeo_3_deduction, expected.total_aeo_deduction, 
		expected.aeo_1_pe_bf, expected.aeo_2_pe_bf, expected.aeo_3_pe_bf, expected.aeo_1_ded_bf, expected.aeo_2_ded_bf, expected.aeo_3_ded_bf, 
		expected.aeo_1_admin_charge, expected.aeo_2_admin_charge, expected.aeo_3_admin_charge, 
		expected.employee_ni_ytd, expected.gross_ytd, expected.pension_ytd, expected.tax_ytd, expected.net_ytd, expected.salary_sacrifice_ytd, 
		expected.loan_1_ytd, expected.loan_2_ytd, expected.loan_3_ytd, expected.aeo_1_ytd, expected.aeo_2_ytd, expected.aeo_3_ytd
	FROM 
		test_result_expected expected
	WHERE
		expected.expected_test_num = testNum
	UNION 
	SELECT
		actual.test_num,
		actual.gross, actual.net, actual.tax, actual.employee_ni, actual.employer_ni, 
		actual.employee_pension, actual.salary_sacrifice, actual.employer_pension, 
		actual.loan_1_deduction, actual.loan_2_deduction, actual.loan_3_deduction, actual.total_loan_deduction, 
		actual.aeo_1_deduction, actual.aeo_2_deduction, actual.aeo_3_deduction, actual.total_aeo_deduction, 
		actual.aeo_1_pe_bf, actual.aeo_2_pe_bf, actual.aeo_3_pe_bf, actual.aeo_1_ded_bf, actual.aeo_2_ded_bf, actual.aeo_3_ded_bf, 
		actual.aeo_1_admin_charge, actual.aeo_2_admin_charge, actual.aeo_3_admin_charge, 
		actual.employee_ni_ytd, actual.gross_ytd, actual.pension_ytd, actual.tax_ytd, actual.net_ytd, actual.salary_sacrifice_ytd, 
		actual.loan_1_ytd, actual.loan_2_ytd, actual.loan_3_ytd, actual.aeo_1_ytd, actual.aeo_2_ytd, actual.aeo_3_ytd    
	FROM
		test_result actual
	WHERE
		 actual.test_num = testNum) AS x;
	
    SET passOrFail = TRUE;
    IF numRecords > 1 THEN
		SET passOrFail = FALSE;
	END IF;
	RETURN passOrFail;
END