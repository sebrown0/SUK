-- ADD THE EMPLOYEE'S AEO(S)
CREATE PROCEDURE `insert_payroll_aeos` (IN payRunId INT)
BEGIN
DECLARE numAEOsForEmp INT;
    DECLARE totalNumAEOs INT;
    DECLARE payrollDataId INT;
    DECLARE idx INT;    
    DECLARE empPayrollId VARCHAR(45);
    DECLARE aeoTypeId INT;
    DECLARE employeeAeoId INT;
        
    DROP TABLE IF EXISTS emps_aeos;
    CREATE TEMPORARY TABLE 
		emps_aeos
	SELECT 
		emp_aeo.*, eti.payroll_id		
	FROM 
		employee_aeo emp_aeo
	INNER JOIN 
		employees_to_include eti ON emp_aeo.employee_id = eti.employee_id	
	WHERE
		emp_aeo.current_amount > 0;
    
    SELECT count(*) INTO totalNumAEOs FROM emps_aeos;    
    SET idx = 0;					
    WHILE idx < totalNumAEOs DO    		        
        SELECT payroll_id, id INTO empPayrollId, employeeAeoId FROM emps_aeos LIMIT idx,1;    
        SELECT id INTO payrollDataId FROM payroll_data  WHERE employee_payroll_id = empPayrollId AND payroll_run_id = payRunId;                
		INSERT INTO payroll_aeo (`payroll_data_id`, `employee_aeo_id`) VALUES (payrollDataId, employeeAeoId);
        SET idx = idx + 1;
	END WHILE;   
END