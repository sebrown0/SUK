CREATE DEFINER=`root`@`localhost` FUNCTION `get_rate_of_pay_anum`(
	employeeType VARCHAR(2), 
    taxYear VARCHAR(4), 
    payFreq VARCHAR(2), 
    avgHours DECIMAL(6,2), 
    basicROP DECIMAL(10,2)) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
	DECLARE rop DECIMAL(10,2);
    
	IF employeeType = "V" THEN
		SET rop = basicROP * avgHours * get_num_pay_days_for_freq(taxYear, payFreq);
	ELSE
		SET rop = basicROP * get_num_pay_days_for_freq(taxYear, payFreq);
    END IF;

	RETURN rop;
END