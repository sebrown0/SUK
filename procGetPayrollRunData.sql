CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_run_data`(
	IN taxYear VARCHAR(4),
    IN payFreq VARCHAR(3),
    IN payNum INT)
BEGIN
	SELECT 
		*    
	FROM
		payroll_run	
	WHERE
		tax_year_id = taxYear
	AND
		payroll_frequency_id = getFrequencyId(payFreq, taxYear)
	AND
		payroll_number = payNum;
END