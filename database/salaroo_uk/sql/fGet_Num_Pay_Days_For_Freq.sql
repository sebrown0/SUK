CREATE DEFINER=`root`@`localhost` FUNCTION `get_num_pay_days_for_freq`(
	taxYear VARCHAR(4), payFreq VARCHAR(2)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE numPayPeriods INT;
    
	SELECT count(*) INTO numPayPeriods 
    FROM salaroo_uk.payroll_dates
	WHERE pay_frequency_id= payFreq AND tax_year = taxYear
	GROUP BY tax_year;

	RETURN numPayPeriods;
END