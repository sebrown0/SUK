USE salaroo_uk;
DROP FUNCTION IF EXISTS getFrequencyId;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getFrequencyId`(freq VARCHAR(3), taxYear VARCHAR(4)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE r_id INT;
	SELECT 
		max(pf.id) 
	INTO 
		r_id 
    FROM 
		payroll_frequency pf 
	WHERE 
		pf.pay_frequency_id = freq
	AND
		pf.tax_year_id = taxYear;
RETURN r_id;
END$$
DELIMITER ;