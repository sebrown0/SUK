CREATE DEFINER=`root`@`localhost` PROCEDURE `get_qual_earn_threshold`(
	IN taxYear VARCHAR(4),
    IN payFreq ENUM('W1', 'W2', 'W4', 'M1', 'MA'))
BEGIN
	SELECT 
		* 
	FROM 
		qualifying_earnings_threshold
	WHERE 
		tax_year = taxYear 
	AND 
		pay_frequency = payFreq;
END