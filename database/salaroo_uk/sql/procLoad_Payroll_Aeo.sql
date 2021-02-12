CREATE DEFINER=`root`@`localhost` PROCEDURE `load_payroll_aeo`(
	IN payrollRunId INT)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
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
    
    DECLARE curAeo
	CURSOR FOR    
	SELECT 
		pd.id, pd.employee_payroll_id, pd.employee_id,
        emp_aeo.id, emp_aeo.priority, emp_aeo.pe_amount, 
        emp_aeo.deduction_amount, emp_aeo.cumulative_unpaid, 
        emp_aeo.order_date, emp_aeo.deduct_admin_charge, 
		tpe.id, tpe.`description` AS type_description, tpe.pe_type, 
        tpe.deduction_type, tpe.is_priority
	FROM 
		employee_aeo emp_aeo
		INNER JOIN 
			payroll_data pd ON emp_aeo.employee_id = pd.employee_id	
			INNER JOIN
				aeo_type tpe ON tpe.id = emp_aeo.aeo_type_id
	WHERE
		pd.payroll_run_id = payrollRunId 
	AND 
		emp_aeo.current_amount > 0 
	AND 
		emp_aeo.`status` = 1;
	
	DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET finished = 1;
    
	OPEN curAeo;
    load_payroll_data: LOOP
		FETCH curAeo         
        INTO    	
        payrollDataId, empPayrollId, empId,     
		employeeAeoId, aeoPriority, peAmount,        
		deductionAmount, cumulativeUnpaid,        
        orderDate, deductAdminCharge,           
        aeoTypeId, aeoTypeDesc, peType,         
		deductionType, isPriority;
        IF finished = 1 THEN LEAVE load_payroll_data; END IF;                   
        
		INSERT INTO payroll_aeo (
			`payroll_data_id`, `employee_aeo_id`, `is_priority`, `priority`, `deduction_amount`, `deduction_type`, `cumulative_unpaid`, 
			`pe_type`, `pe_amount`, `deduct_admin_charge`, `aeo_type_description`, `order_date`, `employee_id`) 
		VALUES (
			payrollDataId, employeeAeoId, isPriority, aeoPriority, deductionAmount, deductionType, 
            cumulativeUnpaid, peType, peAmount, deductAdminCharge, aeoTypeDesc, orderDate, empId);
		
	END LOOP;    
END