CREATE DEFINER=`root`@`localhost` FUNCTION `get_eligibility_id_for_name`(eCode VARCHAR(20)) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE foundId INT;
    
	SELECT id INTO foundId FROM salaroo_uk_pension_test.eligibility
	WHERE code = eCode;
	
    RETURN foundId;
END