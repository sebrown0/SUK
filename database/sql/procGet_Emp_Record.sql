CREATE DEFINER=`root`@`localhost` PROCEDURE `get_emp_record`(IN empPayrollID VARCHAR(25))
BEGIN
	-- Get the fields needed to create a record for an employee.
    CALL create_all_emp_records();    
	SELECT * FROM temp_all_emp_recs WHERE payroll_id = empPayrollID;	
END