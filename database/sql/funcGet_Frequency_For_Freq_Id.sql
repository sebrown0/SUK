CREATE DEFINER=`root`@`localhost` FUNCTION `get_frequency_for_freq_id`(freqId INT) RETURNS varchar(4) CHARSET utf8
    DETERMINISTIC
BEGIN
	DECLARE frequency VARCHAR(4);
    SELECT pay_frequency_id INTO frequency FROM salaroo_uk.payroll_frequency WHERE id = freqId;
	RETURN frequency;
END