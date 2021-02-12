CREATE DEFINER=`root`@`localhost` PROCEDURE `update_after_salary_sacrifice`(
	IN empPayrollId VARCHAR(45),
    IN sacrificeAmount DECIMAL(9,2),
    INOUT belowMinWage TINYINT)
BEGIN
	-- ------------------------------------------------------------------
	-- When a emp has a salary sacrifice record 
    -- inserted or updated the rate of pay is updated 
    -- using this procedure and triggers on employee_salary_sacrifice.
    
    -- The Notional rate of pay is set to the old rate of pay.
    -- If this is incorrect it will have to be updated manually.
    --
    -- Assumptions:
    -- 1. The tax year is the highest year in the tax_year table.ALTER
    -- 2. If an employee is an apprentice they get the apprentice rate
    --    no matter which year they're in. (see get_minimum_wage_for_emp) 
    -- ------------------------------------------------------------------
    
	DECLARE oldRateOfPay DECIMAL(9,2) DEFAULT 0;
    DECLARE newRateOfPay DECIMAL(9,2) DEFAULT 0;
    DECLARE notionalRateOfPay DECIMAL(9,2) DEFAULT 0;
    DECLARE avgHoursWeek DECIMAL(5,2) DEFAULT 0;
    DECLARE employeeType VARCHAR(1);    
    DECLARE minRateOfPay DECIMAL(9,2);
    DECLARE taxYear VARCHAR(4) DEFAULT '2021';
    
    -- Get the required fields - start.
    SELECT MAX(id) FROM tax_year INTO taxYear;    
    SELECT get_minimum_rate_of_pay_for_emp(getEmpId_ForPayrollId(empPayrollId), taxYear) INTO minRateOfPay;    
    SELECT 
		epd.rate_of_pay, epd.notional_rate_of_pay, 
		epd.avg_hours_per_week,	employee_type 
	INTO
		oldRateOfPay, notionalRateOfPay, avgHoursWeek, employeeType
	FROM 
		employee_payroll_details epd
		INNER JOIN employment_type et 
        ON epd.employee_id  = et.employee_id    
	WHERE epd.payroll_id = empPayrollId;
     -- Get the required fields - end.
     
    -- Check to see if the sacrifice amount should be pro-rated.
    IF employeeType = 'V' THEN
		-- Variable hours emp so their rate of pay is hourly, so pro-rate the amount.
		SET newRateOfPay = oldRateOfPay - (sacrificeAmount / (avgHoursWeek * 52));
	ELSE
		SET newRateOfPay = oldRateOfPay - sacrificeAmount;
    END IF;
    
    -- Check if the new rate of pay breaks the min wage.
    IF newRateOfPay < minRateOfPay THEN
		SET belowMinWage = TRUE;		
    END IF;
    -- Update the payroll details with the new rate of pay.
	UPDATE employee_payroll_details
    SET rate_of_pay = newRateOfPay, notional_rate_of_pay = oldRateOfPay
    WHERE payroll_id = empPayrollId;
END