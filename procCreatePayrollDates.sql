DELIMITER $$
USE salaroo_uk $$
DROP PROCEDURE IF EXISTS `create_payroll_dates` $$
CREATE PROCEDURE create_payroll_dates (IN tax_year varchar(4))
BEGIN	
	DECLARE pay_num INT;
    DECLARE date_from DATE;
    DECLARE date_to DATE;
    DECLARE end_date DATE;
    DECLARE last_day DATE;
    
    DELETE FROM payroll_dates WHERE id != '' AND payroll_dates.tax_year = tax_year;
    
    -- SET tax_year = year(date_sub(concat(tax_year,'-01-01'), INTERVAL 1 YEAR));
    SET end_date = DATE(concat(tax_year,'-04-05'));
    
    -- M1
    SET pay_num = 1;
    SET date_from = concat(tax_year,'-04-06');
    SET date_to = concat(tax_year,'-05-05');
    WHILE pay_num <= 12 DO		
		INSERT INTO 
			`payroll_dates` (`tax_year`, `pay_frequency_id`, `payroll_number`, `date_from`, `date_to`) 
		VALUES 
			(tax_year, 'M1', pay_num, date_from, date_to);
		SET date_from = date_add(date_from, INTERVAL 1 MONTH);
        SET date_to = date_add(date_to, INTERVAL 1 MONTH);
		SET pay_num = pay_num + 1;        
    END WHILE;
    
    -- W1
    SET pay_num = 1;    
    SET date_from = concat(tax_year,'-04-06');
    SET date_to = date_add(date_from, INTERVAL 6 DAY);
    
    WHILE pay_num <= 52 DO 
		INSERT INTO 
			`payroll_dates` (`tax_year`, `pay_frequency_id`, `payroll_number`, `date_from`, `date_to`) 
		VALUES 
			(tax_year, 'W1', pay_num, date_from, date_to);
            
		SET date_from = date_add(date_to, INTERVAL 1 DAY);
        SET date_to = date_add(date_from, INTERVAL 6 DAY);
		SET pay_num = pay_num + 1;        
    END WHILE;
    
    -- set week 53 if there is one
    SET last_day = date_from;
    WHILE last_day <= end_date DO
		SET last_day = date_add(last_day, INTERVAL 1 DAY);
    END WHILE;
    
    INSERT INTO 
		`payroll_dates` (`tax_year`, `pay_frequency_id`, `payroll_number`, `date_from`, `date_to`) 
	VALUES 
		(tax_year, 'W1', pay_num, date_from, last_day);
    	
END$$
DELIMITER ;