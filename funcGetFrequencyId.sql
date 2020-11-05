CREATE DEFINER=`root`@`localhost` FUNCTION `getFrequencyId`(freq VARCHAR(3)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE r_id INT;
	SELECT max(pf.id) INTO r_id FROM payroll_frequency pf WHERE pf.pay_frequency_id = freq;
RETURN r_id;
END