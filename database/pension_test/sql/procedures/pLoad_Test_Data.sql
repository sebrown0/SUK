CREATE DEFINER=`root`@`localhost` PROCEDURE `load_test_data`(IN testNum INT)
BEGIN
	DECLARE empPenId VARCHAR(40);
    DECLARE empId VARCHAR(20);
    DECLARE empPayrollId VARCHAR(20);
    DECLARE penSchemeId VARCHAR(20);
    DECLARE testDateAsDate DATE;
    
    SET foreign_key_checks = 0;
    
	DROP TABLE IF EXISTS temp_test_data;
    CREATE TEMPORARY TABLE temp_test_data
	SELECT * FROM salaroo_uk_pension_test.test_data
    WHERE test_num = testNum;
    
	SELECT employee_pension_id, employee_id, emp_payroll_id, pension_scheme_id, (SELECT str_to_date(test_date,"%d/%m/%Y")) 
    INTO empPenId, empId, empPayrollId, penSchemeId, testDateAsDate
    FROM temp_test_data;
    
    -- The order of calling is important because assessment looks up other tables.
    CALL insert_prp_qual_earnings(empPenId, testDateAsDate);
    CALL insert_notices_due(empPenId, empId);
    CALL insert_employee_eligibility(empPenId);
    CALL insert_employee_postponement(empPenId);
    CALL insert_employee_enroled(empPenId, empId);
    CALL insert_assessment_result(empPenId);
   
	SET foreign_key_checks = 1;
END