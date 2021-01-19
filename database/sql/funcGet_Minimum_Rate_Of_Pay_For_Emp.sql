CREATE DEFINER=`root`@`localhost` FUNCTION `get_minimum_rate_of_pay_for_emp`(
	empCode VARCHAR(45), 
    taxYr VARCHAR(4)) RETURNS decimal(9,2)
    DETERMINISTIC
BEGIN
	-- ------------------------------------
    -- Converts the minimum wage value into
    -- the minimum rate of pay for an emp.
    -- Assumptions:
    -- 1. 52 weeks in the year.
    -- 2. There are only 2 pay frequencies (M1/W1).
    -- ------------------------------------
	DECLARE mwv DECIMAL(4,2) DEFAULT 0;
    DECLARE mrop DECIMAL(9,2) DEFAULT 0;
    DECLARE avgHoursWeek DECIMAL(5,2) DEFAULT 0;
    DECLARE employeeType VARCHAR(1);    
    DECLARE payFrequency VARCHAR(2);    
    
    -- Get the min hourly rate.
    SET mwv = get_minimum_wage_for_emp(empCode, taxYr);
    
    SELECT 		
		epd.avg_hours_per_week, epd.pay_frequency,	
        et.employee_type 
	INTO
		avgHoursWeek, payFrequency, employeeType
	FROM 
		employee_payroll_details epd
		INNER JOIN employment_type et 
        ON epd.employee_id  = et.employee_id    
	WHERE epd.employee_id = empCode;

	IF employeeType = 'V' THEN
		SET mrop = mwv;
    ELSE
		IF payFrequency = 'M1' THEN
			SET mrop = (avgHoursWeek * 52 * mwv) / 12;
		ELSE
			SET mrop = avgHoursWeek * mwv;
        END IF;
    END IF;
	RETURN mrop;
END