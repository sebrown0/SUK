CREATE DEFINER=`root`@`localhost` PROCEDURE `diff_expected_and_actual_result`(
	IN testNum INT,
    IN truncateDiffTble TINYINT)
BEGIN
	-- Diff the actual and expected results.
    -- If there are any differences copy the field name and values to test_diff_result.
    -- If truncateDiffTble is TRUE, test_diff_result is truncated before the diff.
	DECLARE resultId INT;
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE fieldName VARCHAR(45);
    DECLARE firstField VARCHAR(45) DEFAULT 'gross';
    DECLARE foundFirstField TINYINT DEFAULT 0;    
    DECLARE sqlStr VARCHAR(255) DEFAULT '';
        
	DECLARE curFieldsInTestResult 
		CURSOR FOR 
			SELECT column_name	FROM INFORMATION_SCHEMA.COLUMNS
			WHERE table_name = 'test_result'
			ORDER BY ordinal_position;

	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
                
    DROP TABLE IF EXISTS expected_result;
    CREATE TEMPORARY TABLE expected_result    
	SELECT  
		"Expected" AS result, expected.expected_test_num AS test_num,
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
		expected.expected_test_num = testNum;        
        	
    -- Get the id of the last test result for the test number
    SELECT id INTO resultId FROM test_result WHERE test_num = testNum ORDER BY tested_on desc LIMIT 1;
    -- Get the data from the last test run (using resultId)
	DROP TABLE IF EXISTS actual_result;
    CREATE TEMPORARY TABLE actual_result
	SELECT 
		"Act" AS result, actual.test_num AS test_num,
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
		) AS actual;
                
	-- Truncate the diff result table if flag is set.  
	IF truncateDiffTble = 1 THEN 
		TRUNCATE test_diff_result; 		
	END IF;           
                
	OPEN curFieldsInTestResult;
    getFieldNames: LOOP
		FETCH curFieldsInTestResult INTO fieldName;
        IF finished = 1 THEN LEAVE getFieldNames; END IF;
        IF fieldName = firstField AND foundFirstField = 0 THEN 
			SET foundFirstField = 1; 
		END IF;
        
        -- Start diffing from the first field we're interested in.
		IF foundFirstField = 1 THEN		
			SET sqlStr = CONCAT("SELECT ", fieldName, " INTO @expectedfieldVal FROM expected_result;");
			SET @expectedfieldValSql = sqlStr;
            PREPARE expectedStmnt FROM @expectedfieldValSql;
			EXECUTE expectedStmnt;
            
            SET sqlStr = CONCAT("SELECT ", fieldName, " INTO @actualfieldVal FROM actual_result;");
            SET @actualfieldValSql = sqlStr;
            PREPARE actualStmnt FROM @actualfieldValSql;
			EXECUTE actualStmnt;
            
			SET @diffSql = CONCAT ("SELECT(@actualfieldVal = @expectedfieldVal) INTO @diff;");                    
			PREPARE stmnt FROM @diffSql;
			EXECUTE stmnt;            		
                
			IF @diff = 0 THEN			
				-- There is a difference, insert the errored field.            
				INSERT INTO test_diff_result (test_result_id, test_num, field_name, expected, actual )
				VALUES (resultId, testNum, fieldName, @expectedfieldVal, @actualfieldVal);            
			END IF;
		END IF;
    END LOOP;	
END