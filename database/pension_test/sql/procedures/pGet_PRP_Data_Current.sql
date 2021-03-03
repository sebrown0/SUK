CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prp_data_current`(
    IN payFreq VARCHAR(2))
BEGIN
    SELECT 
		* 
	FROM 
		pay_reference_period
	WHERE 
		pay_frequency = payFreq
	AND 
		CURDATE() >= date_from 
	AND 
		CURDATE() <= date_to;     
END