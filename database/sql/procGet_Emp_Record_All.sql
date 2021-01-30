CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_record_all`()
BEGIN
	-- Get the fields needed to create a record for all employees.
    CALL create_all_emp_records();    
	SELECT * FROM temp_all_emp_recs;	
END