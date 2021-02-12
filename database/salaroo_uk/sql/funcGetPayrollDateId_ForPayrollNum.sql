DELIMITER $$
USE salaroo_uk$$
DROP FUNCTION IF EXISTS `getPayrollDateId_ForPayrollNum` $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getPayrollDateId_ForPayrollNum`(
	freq_id VARCHAR(4),
    tax_yr VARCHAR(4),
    payroll_num INT) RETURNS int
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
		pd.payroll_number = payroll_num;
        
	RETURN row_id;
END$$
DELIMITER ;