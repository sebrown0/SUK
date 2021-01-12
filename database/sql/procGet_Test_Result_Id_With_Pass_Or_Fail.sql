CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_result_id_with_pass_or_fail`(IN testNum INT)
BEGIN
	DECLARE passOrFail BOOLEAN;
    DECLARE numRecords INT;    
    DECLARE resultId INT;
    -- Get the id of the last test result for the test number
    SELECT id INTO resultId FROM test_result WHERE test_num = testNum ORDER BY tested_on desc LIMIT 1;
                
	-- Union the expected result with the latest actual result.
    -- If there is more than one rec the test has failed.
	SELECT COUNT(*) INTO numRecords FROM (
		SELECT  
			expected.expected_test_num,
			expected.gross, expected.net, expected.tax, expected.employee_ni, expected.employer_ni, 
			expected.employee_pension, expected.salary_sacrifice, expected.employer_pension, 
			expected.loan_1_deduction, expected.loan_2_deduction, expected.loan_3_deduction, expected.total_loan_deduction, 
			expected.aeo_1_deduction, expected.aeo_2_deduction, expected.aeo_3_deduction, expected.total_aeo_deduction, 
			expected.aeo_1_pe_cf, expected.aeo_2_pe_cf, expected.aeo_3_pe_cf, expected.aeo_1_ded_cf, expected.aeo_2_ded_cf, expected.aeo_3_ded_cf, 
			expected.aeo_1_admin_charge, expected.aeo_2_admin_charge, expected.aeo_3_admin_charge, 
			expected.employee_ni_ytd, expected.gross_ytd, expected.pension_ytd, expected.tax_ytd, expected.net_ytd, expected.salary_sacrifice_ytd, 
			expected.loan_1_ytd, expected.loan_2_ytd, expected.loan_3_ytd, expected.aeo_1_ytd, expected.aeo_2_ytd, expected.aeo_3_ytd
		FROM 
			test_result_expected expected
		WHERE
			expected.expected_test_num = testNum
		UNION 
		SELECT 
			actual.test_num AS actual_test_num,
			actual.gross, actual.net, actual.tax, actual.employee_ni, actual.employer_ni, 
			actual.employee_pension, actual.salary_sacrifice, actual.employer_pension, 
			actual.loan_1_deduction, actual.loan_2_deduction, actual.loan_3_deduction, actual.total_loan_deduction, 
			actual.aeo_1_deduction, actual.aeo_2_deduction, actual.aeo_3_deduction, actual.total_aeo_deduction, 
			actual.aeo_1_pe_cf, actual.aeo_2_pe_cf, actual.aeo_3_pe_cf, actual.aeo_1_ded_cf, actual.aeo_2_ded_cf, actual.aeo_3_ded_cf, 
			actual.aeo_1_admin_charge, actual.aeo_2_admin_charge, actual.aeo_3_admin_charge, 
			actual.employee_ni_ytd, actual.gross_ytd, actual.pension_ytd, actual.tax_ytd, actual.net_ytd, actual.salary_sacrifice_ytd, 
			actual.loan_1_ytd, actual.loan_2_ytd, actual.loan_3_ytd, actual.aeo_1_ytd, actual.aeo_2_ytd, actual.aeo_3_ytd 
		FROM (
			SELECT     
				*   
			FROM
				test_result 	
			WHERE
				id = resultId
			) AS actual) AS num_recs;
            
	SET passOrFail = TRUE;
    IF numRecords > 1 THEN
		SET passOrFail = FALSE;
	END IF;
    
    SELECT passOrFail AS test_passed, resultId AS result_id;
END