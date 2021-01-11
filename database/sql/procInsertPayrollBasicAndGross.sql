-- CREATE A PAYROLL DATA ENTRY FOR EACH EMPLOYEE IN THE PAYROLL
CREATE PROCEDURE `insert_payroll_basic_and_gross` (IN payRunId INT)
BEGIN
DECLARE numEmps INT;
    DECLARE idx INT;
    DECLARE empPayrollId VARCHAR(45);
    DECLARE payrollDataId INT;
    DECLARE basicTotal DECIMAL(10,2);
    DECLARE basicRate DECIMAL(10,2);
    DECLARE basicUnits INT;
    DECLARE empType VARCHAR(1);
    DECLARE totalGross DECIMAL (10,2);
    DECLARE commisionGross DECIMAL (10,2);
    DECLARE bonusGross DECIMAL (10,2);
    DECLARE overtime_15Gross DECIMAL (10,2);
    DECLARE overtimeTotalGross DECIMAL (10,2);
        
    DROP TABLE IF EXISTS `all_emps_payroll_type`;
	CREATE TEMPORARY TABLE `all_emps_payroll_type`
	SELECT 
		inc_emps.payroll_id, inc_emps.employee_id, inc_emps.tax_rate, inc_emps.rate_of_pay, 
		inc_emps.commision_percentage, inc_emps.gets_blind_allowance, inc_emps.nic, inc_emps.pay_frequency,
		et.employee_type, et.is_apprentice, et.is_casual_worker, et.primary_employment
	FROM 
		employees_to_include inc_emps
	LEFT JOIN 
		employment_type et ON inc_emps.employee_id = et.employee_id
	ORDER BY
		et.employee_type;
        
	SELECT count(*) INTO numEmps FROM all_emps_payroll_type;
    SET idx = 0;
    WHILE idx < numEmps DO		
        SELECT payroll_id, employee_type, rate_of_pay INTO empPayrollId, empType, basicRate FROM all_emps_payroll_type LIMIT idx,1;                
        SELECT id INTO payrollDataId FROM payroll_data  WHERE employee_payroll_id = empPayrollId AND payroll_run_id = payRunId;        
        SELECT basic_hours, commission, bonus, overtime_15 INTO basicUnits, commisionGross, bonusGross, overtime_15Gross FROM payroll_test_data WHERE emp_payroll_id = empPayrollId;        
       
		SET overtimeTotalGross = 0;
        IF empType = 'V' THEN
			SELECT payroll_test_data.basic_hours INTO basicUnits FROM payroll_test_data WHERE emp_payroll_id = empPayrollId;        
            SET overtimeTotalGross = basicRate * overtime_15Gross;
		ELSE
			SET basicUnits = 1;        
        END IF;
        SET basicTotal = basicUnits * basicRate;
      
        INSERT INTO `payroll_basic` (`payroll_data_id`, `units`, `rate`, `total`) VALUES (payrollDataId, basicUnits, basicRate, basicTotal);	
        
        SET totalGross = basicTotal + commisionGross + bonusGross + overtimeTotalGross;
        INSERT INTO `payroll_gross` (`payroll_data_id`, `commision`, `total_gross`, `bonus`, `overtime`) VALUES (payrollDataId, commisionGross, totalGross, bonusGross, overtimeTotalGross);
        SET idx = idx + 1;
	END WHILE;   
END