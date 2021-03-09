CREATE DEFINER=`root`@`localhost` FUNCTION `get_asmnt_result_id`(resultCode VARCHAR(45)) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	DECLARE resId TINYINT;
    
	SELECT id INTO resId 
    FROM assessment_result 
    WHERE result_code = resultCode;
    
    IF resId IS NULL THEN
		SET resId = -1;
	END IF;
    
    RETURN resId;
END