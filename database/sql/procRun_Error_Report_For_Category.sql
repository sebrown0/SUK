CREATE DEFINER=`root`@`localhost` PROCEDURE `run_error_report_for_category`(
	IN categoryIdent VARCHAR(20),
    IN subCategoryIdent VARCHAR(20))
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE testNum INTEGER DEFAULT 0;
    
    DECLARE curTestNums 
	CURSOR FOR 
	SELECT * from test_nums_for_category;

	DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET finished = 1;
	
    -- Clear the diff result table.
    TRUNCATE test_diff_result; 	
    -- Load the test nums for the category into a temp table.
    CALL create_temp_tbl_for_test_nums_for_category(categoryIdent, subCategoryIdent);
    
    OPEN curTestNums;
    getTestNums:LOOP
		FETCH curTestNums INTO testNum;
        IF finished = 1 THEN LEAVE getTestNums; END IF;        
		CALL diff_expected_and_actual_result(testNum, FALSE);
    END LOOP;
    
    -- Get the errored fields with the the test description.
	SELECT 
		t.test_num, t.description, r.field_name, r.expected, r.actual  
    FROM 
		salaroo_uk.test_diff_result r
	INNER JOIN 
		test t ON r.test_num = t.test_num;
END