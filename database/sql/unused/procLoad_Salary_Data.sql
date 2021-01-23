CREATE DEFINER=`root`@`localhost` PROCEDURE `load_salary_data`(
	IN forEmpPayrollId VARCHAR(45),
    IN commision DECIMAL(8,2), 
    IN bonus DECIMAL(10,2), 
    IN expenses DECIMAL(8,2), 
    IN pension DECIMAL(8,2), 
    IN otHours DECIMAL(5,2),
    IN basicUnits DECIMAL(6,2))
BEGIN
	/* 	HAVE TO LOAD THIS MANUALL UNTIL FIGURED OUT WHY 
		THERE'S A SYNTAX ERROR IN WORKBENCH ROUTINES */
        
	-- -------------------------------------------------------------------- --
	-- Take an emp's salary data and load it into payroll_salary_data.	    --
    -- The data is modified as necessary to calc OT, basic etc depending on --
    -- the emp type salaried/variable/PT.									--
    -- -------------------------------------------------------------------- --
    DECLARE salSacPension DECIMAL(10,2) DEFAULT 0.00;
    DECLARE salSacOther DECIMAL(10,2) DEFAULT 0.00;
    DECLARE salSacTotal DECIMAL(10,2) DEFAULT 0.00;    
	DECLARE basicRate DECIMAL(10,2) DEFAULT 0.00;
    DECLARE hoursWorked DECIMAL(6,2) DEFAULT 0.00;
    DECLARE otRate DECIMAL(5,2) DEFAULT 1.5;
    DECLARE otAmount DECIMAL(6,2) DEFAULT 0.00;
    DECLARE employeeType ENUM('S', 'P', 'V');
    DECLARE basicTotal DECIMAL(9,2) DEFAULT 0.00;
    DECLARE grossTotal DECIMAL(10,2) DEFAULT 0.00;
        
    -- Get the salary sacrifice totals
    CALL get_sal_sac_totals(forEmpPayrollId, salSacPension, salSacOther);
    SET salSacTotal = salSacPension + salSacOther;
    
    -- Calculate the differences between variable/salaried/pt emps.
    SET employeeType = getEmpType_ForPayrollId(forEmpPayrollId);
	IF NOT employeeType = 'V' THEN			
		SET basicUnits = 1; -- Always set the units to one unless the emp is variable hours.            
		SET otHours = 0; 	-- Only variable emps can have OT.
        SET otAmount = 0;
        SET otRate = 0;
		SET hoursWorked = get_emp_avg_hours_week(forEmpPayrollId); -- Can not have variable hours
		SET basicTotal = get_emp_rate_of_pay(forEmpPayrollId);
	ELSE
		SET hoursWorked = basicUnits + otHours;
		SET basicTotal = get_emp_rate_of_pay(forEmpPayrollId) * basicUnits;
		-- We are just using the one OT rate of time and a half.
		-- This could be expanded to other rates, i.e. pass the rate as a param.
		SET otAmount = (basicRate * otRate) * otHours;
	END IF;
	SET grossTotal = basicTotal + otAmount + bonus + pension + commision;
    
    INSERT INTO payroll_salary_data (
		`emp_payroll_id`, `emp_id`, `pay_frequency`, `nic`, `tax_code`, `tax_rate`, 
        `basic_rate`, `notional_salary`,
        `basic_units`, `hours_worked`, `basic_total`,
		`pension_total`, `commision`, `bonus`, `expenses`,
         `ot_hours`, `ot_rate`, `ot_amount`,
        `date_added`, `salary_sacrifice_pension`,`salary_sacrifice_total`
        )   
		WITH 
		emp_payroll_details AS (
			SELECT 
				payroll_id, employee_id, pay_frequency, nic, tax_code, tax_rate, 
				rate_of_pay, notional_rate_of_pay			
			FROM 
				employee_payroll_details 
			WHERE
				payroll_id = forEmpPayrollId
		), 
		inputed_data AS (
			SELECT forEmpPayrollId, basicUnits, otHours, pension, commision, bonus, expenses
		) 	SELECT 
				epd.*, 
				basicUnits, hoursWorked, basicTotal, inp.pension, inp.commision, inp.bonus, inp.expenses,
				otHours, otRate, otAmount , now(), salSacPension, salSacTotal
			FROM 
				emp_payroll_details epd 
			JOIN 
				inputed_data inp ON inp.forEmpPayrollId = epd.payroll_id;
    
END