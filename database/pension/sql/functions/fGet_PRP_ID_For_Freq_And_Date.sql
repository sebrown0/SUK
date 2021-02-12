CREATE DEFINER=`root`@`localhost` FUNCTION `get_prp_id_for_freq_and_date`(payFreq VARCHAR(2), forDate DATE) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE returnId INT(11);
    
	SELECT 
		id 
	INTO
		returnId
	FROM 
		pay_reference_period 
	WHERE 
		pay_frequency = payFreq
	AND 
		forDate BETWEEN date_from AND date_to;
        
	RETURN returnId;
END