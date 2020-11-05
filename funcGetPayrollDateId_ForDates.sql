DELIMITER $$
USE salaroo_uk$$
DROP FUNCTION IF EXISTS `getPayrollDateId_ForDates` $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getPayrollDateId_ForDates`(
	freq_id VARCHAR(4),
    tax_yr VARCHAR(4),
    from_date DATE, 
    to_date DATE) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE row_id INT;
	SELECT 
		pd.id
	INTO
		row_id
	FROM 
		payroll_dates pd 
	WHERE 
		pd.tax_year = tax_yr
	AND
		pd.pay_frequency_id = freq_id
	AND
		pd.date_from BETWEEN from_date AND to_date;
        
	RETURN row_id;
END$$
DELIMITER ;