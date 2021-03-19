CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prp`(
	IN txYr VARCHAR(4), 
    IN payFreq VARCHAR(2), 
    IN payNum TINYINT)
BEGIN
	SELECT * FROM payroll_dates
    WHERE 
		tax_year=txYr
	AND 
		pay_frequency_id=payFreq
    AND
		payroll_number=payNum;
END