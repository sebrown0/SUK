CREATE DEFINER=`root`@`localhost` PROCEDURE `create_prp_dates`(IN tax_year varchar(4))
BEGIN	
	DECLARE payNum INT;
    DECLARE dateFrom DATE;
    DECLARE dateTo DATE;
    DECLARE runPayrollOn DATE;
    DECLARE payEmpsOn DATE;
    DECLARE endDate DATE;
    DECLARE lastDay DATE;
    
    DELETE FROM pay_reference_period WHERE id != '' AND pay_reference_period.tax_year = tax_year;
    
    SET endDate = DATE(concat(tax_year,'-04-05'));
    
    -- M1
    SET payNum = 1;
    SET dateFrom = concat(tax_year,'-04-06');
    SET dateTo = concat(tax_year,'-05-05');
    SET runPayrollOn = date_add(dateFrom, INTERVAL 28 DAY);
    SET payEmpsOn = runPayrollOn;
    
    WHILE payNum <= 12 DO		
		INSERT INTO 
			`pay_reference_period` (`tax_year`, `pay_frequency`, `prp_number`, `date_from`, `date_to`, `run_payroll_on`, `pay_emps_on`) 
		VALUES 
			(tax_year, 'M1', payNum, dateFrom, dateTo, runPayrollOn, payEmpsOn);
		SET dateFrom = date_add(dateFrom, INTERVAL 1 MONTH);
        SET dateTo = date_add(dateTo, INTERVAL 1 MONTH);
        SET runPayrollOn = date_add(dateFrom, INTERVAL 28 DAY);
		SET payEmpsOn = runPayrollOn;
		SET payNum = payNum + 1;        
    END WHILE;
    
    -- W1
    SET payNum = 1;    
    SET dateFrom = concat(tax_year,'-04-06');
    SET dateTo = date_add(dateFrom, INTERVAL 6 DAY);
    SET runPayrollOn = date_add(dateFrom, INTERVAL 5 DAY);
    SET payEmpsOn = runPayrollOn;
    
    WHILE payNum <= 52 DO 
		INSERT INTO 
			`pay_reference_period` (`tax_year`, `pay_frequency`, `prp_number`,  `date_from`, `date_to`, `run_payroll_on`, `pay_emps_on`) 
		VALUES 
			(tax_year, 'W1', payNum, dateFrom, dateTo, runPayrollOn, payEmpsOn);
            
		SET dateFrom = date_add(dateTo, INTERVAL 1 DAY);
        SET dateTo = date_add(dateFrom, INTERVAL 6 DAY);
        SET runPayrollOn = date_add(dateFrom, INTERVAL 5 DAY);
		SET payEmpsOn = runPayrollOn;
		SET payNum = payNum + 1;        
    END WHILE;
    
    -- set week 53 if there is one
    SET lastDay = dateFrom;
    WHILE lastDay <= endDate DO
		SET lastDay = date_add(lastDay, INTERVAL 1 DAY);
        SET runPayrollOn = lastDay;
		SET payEmpsOn = lastDay;
    END WHILE;
    
    INSERT INTO 
		`pay_reference_period` (`tax_year`, `pay_frequency`, `prp_number`,  `date_from`, `date_to`, `run_payroll_on`, `pay_emps_on`)  
	VALUES 
		(tax_year, 'W1', payNum, dateFrom, lastDay, runPayrollOn, payEmpsOn);
    	
END