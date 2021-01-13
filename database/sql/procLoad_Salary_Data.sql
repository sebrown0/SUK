CREATE DEFINER=`root`@`localhost` PROCEDURE `load_salary_data`(
	IN forEmpPayrollId VARCHAR(45),
    IN basicUnits INT,     		-- For salaried/PT employees this is always 1. For variable hrs this is the hours worked.
    IN commision DECIMAL(8,2), 
    IN bonus DECIMAL(10,2), 
    IN otHours DECIMAL(5,2))
BEGIN
	-- Load the salary data so that it can then be loaded into the 
    -- relevant payroll_xxxx table at payroll run time.
    --
    -- This could be used to pull other details about the emp if required, 
    -- i.e. commission percentage.
	DECLARE basicRate DECIMAL(10,2);
    DECLARE otRate DECIMAL(5,2) DEFAULT 0.00;
    DECLARE employeeType ENUM('S', 'P', 'V');
    DECLARE payFreq ENUM('W1','W2','W4','M1','M3','M6','MA','IO','IR');
    
    -- Get the the known emp details.
    SELECT 
		e.rate_of_pay, e.pay_frequency, t.employee_type
	INTO
		basicRate, payFreq, employeeType
	FROM 
		employee_payroll_details e
		INNER JOIN employment_type t
			ON e.employee_id = t.employee_id
	WHERE
		e.payroll_id = forEmpPayrollId;
        
	check_data:BEGIN
		IF NOT employeeType = 'V' THEN
			-- Always set the units to one unless the emp is variable hours.
			SET basicUnits = 1;
            -- Only variable emps can have OT.
            SET otHours = 0;
		ELSE
			-- We are just using the one OT rate of time and a half.
            -- This could be expanded to other rates, i.e. pass the rate as a param.
			SET otRate = basicRate * 1.5;
		END IF;
	END check_data;
    
    INSERT INTO 
		salary_data (`emp_payroll_id`, `emp_id`, `pay_frequency`, `basic_units`, `basic_rate`, `commision`, `bonus`, `ot_hours`, `ot_rate`)
    VALUES 
		(forEmpPayrollId, getEmpId_ForPayrollId(forEmpPayrollId), payFreq, basicUnits, basicRate, commision, bonus, otHours, otRate);
END