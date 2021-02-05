CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_records_included_in_payroll`(IN payrollRunId INT)
BEGIN
	-- Get the fields needed to create a record for all employees in payroll run.
    -- --------------------------------------------------------------------------
    
    CALL create_all_emp_records();    
    CALL create_included_emps_for_payroll(payrollRunId);
        
    SELECT * FROM temp_all_emp_recs 
    WHERE payroll_id IN(SELECT * FROM temp_included_emps);	
END