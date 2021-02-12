DELIMITER $$
USE salaroo_uk$$
CREATE DEFINER=`root`@`localhost` FUNCTION `getPayrollNumber`(tax_yr VARCHAR(4), freq VARCHAR(3)) RETURNS INT
    DETERMINISTIC
BEGIN
	DECLARE r_num INT;
	SELECT max(pr.payroll_number) INTO r_num FROM payroll_run pr 
WHERE 
	pr.tax_year_id = tax_yr
AND 
	pr.payroll_frequency_id = getFrequencyId(freq, tax_yr);
RETURN r_num;
END$$
DELIMITER ;