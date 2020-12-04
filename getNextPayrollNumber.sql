CREATE DEFINER=`root`@`localhost` FUNCTION `get_next_payroll_number`(
	taxYr VARCHAR(4), 
    freq VARCHAR(3)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE lastPayNum INT;
    DECLARE nextPayNum INT;
    
    SET lastPayNum = 0;
    SET nextPayNum = 0;
 
	SELECT 
		max(pr.payroll_number) 
	INTO 
		lastPayNum 
	FROM 
		payroll_run pr 
	WHERE 
		pr.tax_year_id = taxYr
	AND 
		pr.payroll_frequency_id = getFrequencyId(freq, taxYr); 

	IF lastPayNum IS NULL OR lastPayNum <= 0  THEN	
		SET nextPayNum = 1;
    ELSEIF	freq = 'W1' AND lastPayNum >= 53 THEN
		SET nextPayNum = 53;
	ELSEIF	freq = 'M1' AND lastPayNum >= 12 THEN
		SET nextPayNum = 12;
	ELSE
		SET nextPayNum = lastPayNum + 1;
    END IF;

	RETURN nextPayNum;
END