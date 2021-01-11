-- CREATE A PAYROLL DATA ENTRY FOR EACH EMPLOYEE IN THE PAYROLL
CREATE PROCEDURE `create_payroll_data_entry` (IN payRunId INT)
BEGIN
DECLARE numEmps INT;
    DECLARE idx INT;
    DECLARE empPayrollId VARCHAR(45);
    
    SET idx = 0;
    SELECT count(*) INTO numEmps FROM included_emps_payroll_id;
    WHILE idx < numEmps DO
		SELECT payroll_id INTO empPayrollId FROM included_emps_payroll_id LIMIT idx,1;
		-- Insert the data
		INSERT INTO 
			`payroll_data` (`payroll_run_id`, `employee_payroll_id`) 
		VALUES 
			(payRunId, empPayrollId);		
        
        SET idx = idx + 1;
	END WHILE;   
END