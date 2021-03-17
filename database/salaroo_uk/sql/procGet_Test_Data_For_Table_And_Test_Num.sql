CREATE DEFINER=`root`@`localhost` PROCEDURE `get_test_data_for_table_and_test_num`(
	IN testTable VARCHAR(45),    
    IN testNum INT)
BEGIN
	-- Generic procedure for getting the test data from a test_data_XXXX table, i.e. test_data_salary.
    -- The table name must be in the format test_data_XXXX where XXXX is the category
    -- and the row id must be in the form XXXX_test_num where XXXX is the category.
    
	DECLARE testNumCol VARCHAR(45);
    -- Construct the row id name (test_num) from the table name given.
	SELECT CONCAT ((SELECT SUBSTR(testTable, 11)), '_test_num') INTO testNumCol;
    
    IF testTable = 'test_data_aeo' THEN
		SET @sql = CONCAT('select * from test_data_aeo where ', testNumCol, ' = ', testNum, ' order by priority'); 
    ELSEIF testTable = 'test_data_student_loan' THEN
		SET @sql = CONCAT('select * from test_data_student_loan where ', testNumCol, ' = ', testNum, ' order by loan_type'); 
	/* NOW USING PROC get_test_emp_for_test_num
    ELSEIF testTable = 'test_data_employee' THEN
		SET @sql = CONCAT('SELECT emp.* FROM test_data_payroll_params params 
			INNER JOIN test_data_employee emp 
				ON params.emp_payroll_id = emp.payroll_id WHERE params.payroll_params_test_num = ', testNum);         
	*/
    ELSE    
		SET @sql = CONCAT('select * from ', testTable, ' where ', testNumCol, ' = ', testNum); 
    END IF;
	PREPARE stmt1 FROM @sql; 
	EXECUTE stmt1; 
	DEALLOCATE PREPARE stmt1; 
END