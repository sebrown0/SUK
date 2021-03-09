CREATE DEFINER=`root`@`localhost` FUNCTION `get_start_of_next_prp`(taxYear VARCHAR(4),payFreq VARCHAR(4), payNum tinyint) RETURNS date
    DETERMINISTIC
BEGIN
	DECLARE prpStartDate DATE;
    
    SELECT date_from INTO prpStartDate
    FROM salaroo_uk.payroll_dates
	WHERE tax_year= taxYear AND pay_frequency_id = payFreq AND payroll_number = payNum;
	
    IF prpStartDate IS NULL 
		THEN SET prpStartDate = "1900-01-01";
    END IF;
    
    RETURN prpStartDate;
END