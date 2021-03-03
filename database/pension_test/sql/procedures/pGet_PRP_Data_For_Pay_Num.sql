CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prp_data_for_pay_num`(
	IN txYr VARCHAR(4),
    IN payFreq VARCHAR(2), 
    IN prpNum TINYINT)
BEGIN
	SELECT 
		* 
	FROM 
		pay_reference_period
	WHERE 
		tax_year = txYr AND pay_frequency = payFreq AND prp_number = prpNum;
END