-- ADD THE EMPLOYEE'S AEO(S)
DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS `insert_payroll_aeos` $$
CREATE PROCEDURE `insert_payroll_aeos`(IN payRunId INT)
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
		aeot.deduction_type, aeot.pe_type, aeot.unpaid_bf, aeot.priority_order, 
        emp_aeo.*, eti.payroll_id FROM employee_aeo emp_aeo
	INNER JOIN 
		aeo_type aeot ON emp_aeo.aeo_type_id = aeot.id
	INNER JOIN 
		employees_to_include eti ON emp_aeo.employee_id = eti.employee_id
	WHERE
		emp_aeo.current_amount > 0;
    
    SELECT count(*) INTO totalNumAEOs FROM emps_aeos;    
    SET idx = 0;					
    WHILE idx < totalNumAEOs DO    		        
        SELECT payroll_id, aeo_type_id, id INTO empPayrollId, aeoTypeId, employeeAeoId FROM emps_aeos LIMIT idx,1;    
        SELECT id INTO payrollDataId FROM payroll_data  WHERE employee_payroll_id = empPayrollId AND payroll_run_id = payRunId;        
		INSERT INTO payroll_aeo (`payroll_data_id`, `aeo_type_id`, `employee_aeo_id`) VALUES (payrollDataId, aeoTypeId, employeeAeoId);
        SET idx = idx + 1;
	END WHILE;            
END$$
DELIMITER ;
