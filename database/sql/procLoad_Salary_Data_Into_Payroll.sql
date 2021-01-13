CREATE DEFINER=`root`@`localhost` PROCEDURE `load_salary_data_into_payroll`(
	IN payFreq ENUM('W1','W2','W4','M1','M3','M6','MA','IO','IR'))
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    DECLARE basicUnits DECIMAL(5,2); 
	DECLARE basicRate DECIMAL(8,2);
	DECLARE basicTotal DECIMAL(9,2);
	DECLARE commision DECIMAL(8,2);
	DECLARE bonus DECIMAL(8,2);
	DECLARE otHours DECIMAL(5,2);
	DECLARE otRate DECIMAL(5,2);
	DECLARE otAmount DECIMAL(8,2);
	DECLARE totalGross DECIMAL(10,2);
    
	-- Get the latest data for the pay frequency.
	DECLARE curLatestSalaryData
	CURSOR FOR     
		SELECT 
			sal_data.basic_units, 
            sal_data.basic_rate,
            sal_data.basic_total,
            sal_data.commision, 
            sal_data.bonus, 
            sal_data.ot_hours,
            sal_data.ot_rate,
            sal_data.ot_amount,
            sal_data.total_gross
		FROM (
			SELECT 
				MAX(date_added) AS date_added 
				FROM salaroo_uk.salary_data GROUP BY emp_payroll_id) AS latest
					INNER JOIN salary_data sal_data ON sal_data.date_added = latest.date_added
		WHERE sal_data.pay_frequency = payFreq;
  
	DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET finished = 1;
	
                
	OPEN curLatestSalaryData;
    load_payroll_data: LOOP
		FETCH curLatestSalaryData         
        INTO    
			basicUnits, basicRate, basicTotal,
			commision,bonus,
			otHours, otRate, otAmount,
			totalGross;
		IF finished = 1 THEN LEAVE load_payroll_data; END IF;
        INSERT INTO `salaroo_uk`.`payroll_gross` (`id`, `payroll_data_id`, `commision`, `total_gross`, `bonus`, `overtime`) 
        VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
        
        INSERT INTO `salaroo_uk`.`payroll_basic` (`id`, `payroll_data_id`, `units`, `rate`, `total`) 
        VALUES (NULL, NULL, NULL, NULL, NULL);
		
	END LOOP load_payroll_data;
	/*
	DROP TABLE IF EXISTS sal_data_for_this_payroll;
    CREATE TEMPORARY TABLE sal_data_for_this_payroll
	SELECT 
		sal_data.* 
    FROM (
		SELECT 
			MAX(date_added) AS date_added FROM salaroo_uk.salary_data GROUP BY emp_payroll_id) AS latest
			INNER JOIN salary_data sal_data ON sal_data.date_added = latest.date_added
	WHERE sal_data.pay_frequency = payFreq;
    */
    
    -- SELECT * FROM sal_data_for_this_payroll;
END