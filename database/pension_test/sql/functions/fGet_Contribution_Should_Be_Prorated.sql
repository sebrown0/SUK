CREATE DEFINER=`root`@`localhost` FUNCTION `get_contribution_should_be_prorated`(
	empCode VARCHAR(20), 
    txYr VARCHAR(4),
    payFreq VARCHAR(2), 
    prpNum INTEGER) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	DECLARE enrolmentDate DATE;
    DECLARE prpStartDate DATE;
	DECLARE shouldProrate TINYINT DEFAULT 0;
    
    SET enrolmentDate = get_worker_enroled_date(empCode);
    
    SELECT date_from INTO prpStartDate
    FROM pay_reference_period
	WHERE prp_number = prpNum AND pay_frequency = payFreq AND tax_year = txYr;

	IF enrolmentDate > prpStartDate THEN
		SET shouldProrate = 1;
    END IF;
    
    RETURN shouldProrate;
END