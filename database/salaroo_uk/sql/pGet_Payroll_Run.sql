CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_run`(
	IN tax_year VARCHAR(4),
    IN pay_freq VARCHAR(3))
BEGIN
	SELECT * FROM payroll_run 
	WHERE 
		tax_year_id = tax_year 
	AND 		
        payroll_frequency_id = getFrequencyId(pay_freq, tax_year)
	ORDER BY payroll_number DESC
	LIMIT 1;
END