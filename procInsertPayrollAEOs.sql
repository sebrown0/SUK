CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_payroll_aeos`(IN payRunId INT)
BEGIN
DECLARE numAEOsForEmp INT;
    DECLARE totalNumAEOs INT;
    DECLARE payrollDataId INT;
    DECLARE idx INT;    
    DECLARE empPayrollId VARCHAR(45);
    DECLARE empId VARCHAR(45);
    DECLARE aeoTypeDesc VARCHAR(100);
    DECLARE aeoTypeId INT;
    DECLARE employeeAeoId INT;
    DECLARE aeoPriority INT;
    DECLARE isPriority TINYINT;
    DECLARE deductionAmount DECIMAL(8,2);
    DECLARE deductionType ENUM('T', 'V', 'D');
    DECLARE cumulativeUnpaid DECIMAL(8,2); 
    DECLARE peType ENUM('P', 'A', 'N', 'D');
    DECLARE peAmount DECIMAL(8,2);
    DECLARE deductAdminCharge TINYINT;
    DECLARE orderDate DATE;
        
    DROP TABLE IF EXISTS emps_aeos;
    CREATE TEMPORARY TABLE 
		emps_aeos
	SELECT 
		emp_aeo.*, 
		eti.payroll_id,
		tpe.description as type_description, tpe.pe_type, tpe.is_unpaid_deduction_bf, tpe.deduction_type, tpe.is_priority
	FROM 
		employee_aeo emp_aeo
		INNER JOIN 
			employees_to_include eti ON emp_aeo.employee_id = eti.employee_id	
			INNER JOIN
				aeo_type tpe ON tpe.id = emp_aeo.aeo_type_id
	WHERE
		emp_aeo.current_amount > 0; -- ADD STATUS TO THE WHERE CLAUSE
    
    SELECT count(*) INTO totalNumAEOs FROM emps_aeos;    
    SET idx = 0;					
    WHILE idx < totalNumAEOs DO    		        
        SELECT 
			payroll_id, id, is_priority, priority, deduction_amount, deduction_type, cumulative_unpaid, 
            pe_type, pe_amount, deduct_admin_charge, type_description, order_date, employee_id
		INTO 
			empPayrollId, employeeAeoId, isPriority, aeoPriority, deductionAmount, deductionType, cumulativeUnpaid, 
            peType, peAmount, deductAdminCharge, aeoTypeDesc, orderDate, empId 
        FROM 
			emps_aeos 
		LIMIT idx,1;    
        
        SELECT id INTO payrollDataId FROM payroll_data  WHERE employee_payroll_id = empPayrollId AND payroll_run_id = payRunId;     
        
		INSERT INTO payroll_aeo 
			(`payroll_data_id`, `employee_aeo_id`, `is_priority`, `priority`, `deduction_amount`, `deduction_type`, `cumulative_unpaid`, 
            `pe_type`, `pe_amount`, `deduct_admin_charge`, `aeo_type_description`, `order_date`, `employee_id`) 
        VALUES 
			(payrollDataId, employeeAeoId,isPriority, aeoPriority, deductionAmount, deductionType, cumulativeUnpaid, 
            peType, peAmount, deductAdminCharge, aeoTypeDesc, orderDate, empId);
        SET idx = idx + 1;
	END WHILE;   
END