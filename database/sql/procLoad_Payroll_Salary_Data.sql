CREATE DEFINER=`root`@`localhost` PROCEDURE `load_payroll_salary_data`(
	IN taxYr VARCHAR(4),
    IN freqId INT,    
    IN payrollNumber INT)
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE basicUnits DECIMAL(5,2); 
	DECLARE basicRate DECIMAL(8,2);
	DECLARE basicTotal DECIMAL(9,2);
	DECLARE commission DECIMAL(8,2);
	DECLARE bonus DECIMAL(8,2);
	DECLARE otHours DECIMAL(5,2);
	DECLARE otRate DECIMAL(5,2);
	DECLARE otAmount DECIMAL(8,2);
	DECLARE totalGross DECIMAL(10,2); 
    DECLARE payrollDataIdForEmp INT;
    DECLARE empPayrollId VARCHAR(45);
    
    -- Load the latest basic and gross into the payroll tables.
    
	-- Get the latest data for the pay frequency.
    -- For all emps with the pay frequency.
	DECLARE curLatestSalaryData
	CURSOR FOR     
		SELECT 
			sal_data.emp_payroll_id,
			sal_data.basic_units, sal_data.basic_rate, sal_data.basic_total,
            sal_data.commision, sal_data.bonus, 
            sal_data.ot_hours, sal_data.ot_rate, sal_data.ot_amount,
            sal_data.total_gross
		FROM (
			SELECT 
				MAX(date_added) AS date_added , emp_payroll_id
				FROM salaroo_uk.salary_data GROUP BY emp_payroll_id) AS latest
					 INNER JOIN salary_data sal_data 
						ON latest.date_added = sal_data.date_added 
						AND latest.emp_payroll_id = sal_data.emp_payroll_id
		WHERE sal_data.pay_frequency = get_frequency_for_freq_id(freqId);	
  
	DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET finished = 1;
    
    OPEN curLatestSalaryData;
    load_payroll_data: LOOP
		FETCH curLatestSalaryData         
        INTO    
			empPayrollId,
			basicUnits, basicRate, basicTotal,
			commission, bonus,
			otHours, otRate, otAmount,
			totalGross;
	
        IF finished = 1 THEN LEAVE load_payroll_data; END IF;    
        SET payrollDataIdForEmp = 
			get_payroll_data_id_for_pay_num(empPayrollId, taxYr, freqId, payrollNumber);
       
        INSERT INTO payroll_gross (`payroll_data_id`, `commision`, `total_gross`, `bonus`, `overtime`)         
        VALUES (payrollDataIdForEmp, commission, totalGross, bonus, otAmount)
        ON DUPLICATE KEY UPDATE `commision` = commission, `total_gross` = totalGross, `bonus` = bonus, `overtime` = otAmount;
        
        INSERT INTO payroll_basic (`payroll_data_id`, `units`, `rate`, `total`) 
        VALUES (payrollDataIdForEmp, basicUnits, basicRate, basicTotal)
		ON DUPLICATE KEY UPDATE `units` = basicUnits, `rate` = basicRate, `total` = basicTotal;
		
	END LOOP load_payroll_data;	
END