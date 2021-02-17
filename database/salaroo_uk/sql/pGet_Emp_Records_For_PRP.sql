CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_records_for_prp`(IN payFreq VARCHAR(2))
BEGIN
	-- Get the fields needed to create a record for all employees in PRP.
    -- ------------------------------------------------------------------
	CALL create_all_emp_records();    
    CALL create_included_emps_for_prp(payFreq);    
  
    SELECT * FROM temp_all_emp_recs 
    WHERE payroll_id IN(SELECT * FROM temp_included_emps);
END