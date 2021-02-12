CREATE DEFINER=`root`@`localhost` FUNCTION `get_last_payroll_run_id`(freq VARCHAR(3), tax_yr VARCHAR(4)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE r_id INT;
	SELECT max(pr.id) INTO r_id FROM payroll_run pr 
WHERE 
	pr.tax_year_id = tax_yr
AND 
	pr.payroll_frequency_id = getFrequencyId(freq, tax_yr);
RETURN r_id;
END