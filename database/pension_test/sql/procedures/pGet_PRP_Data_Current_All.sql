CREATE DEFINER=`root`@`localhost` PROCEDURE `get_prp_data_current_all`(IN forDate DATE)
BEGIN
    SELECT 
		* 
	FROM 
		pay_reference_period
	WHERE
        forDate >= date_from 
	AND 
		forDate <= date_to;     
END