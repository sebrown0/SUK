-- CREATE A PAYROLL LEAVE ENTRY FOR EACH EMPLOYEE INCLUDED IN THE PAYROLL
CREATE PROCEDURE `insert_payroll_leave`(IN payRunId INT)
BEGIN
DECLARE numEmps INT;
    DECLARE idx INT;
    DECLARE leaveTypeId INT;
    DECLARE includedDays INT;
    DECLARE payrollDataId INT;
    DECLARE empPayrollId VARCHAR(45);
    
    SET idx = 0;
    SELECT count(*) INTO numEmps FROM employee_leave_for_payroll;        
    /* 
		CONVERT THE INCLUDED DAYS INTO MONETARY AMOUNTS???
    */
    WHILE idx < numEmps DO
		SELECT payroll_id, leave_type_id, days_included INTO empPayrollId, leaveTypeId, includedDays FROM employee_leave_for_payroll LIMIT idx,1;
        SELECT DISTINCT(id) INTO payrollDataId FROM payroll_data  WHERE employee_payroll_id = empPayrollId AND payroll_run_id = payRunId;        
        INSERT INTO 
			`payroll_leave` (`payroll_data_id`, `employee_payroll_id`, `leave_type_id`, `included_days`) 
		VALUES 
			(payrollDataId, empPayrollId, leaveTypeId, includedDays);        	
        
        SET idx = idx + 1;
	END WHILE;         
END