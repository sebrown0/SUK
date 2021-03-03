CREATE DEFINER=`root`@`localhost` FUNCTION `get_enrolment_type_id`(eCode VARCHAR(20)) RETURNS varchar(40) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE enrlTypeId VARCHAR(40);
    
    SELECT enrolment_type_id INTO enrlTypeId 
    FROM employee_enroled 
    WHERE employee_id = eCode LIMIT 1;

	IF enrlTypeId IS NULL THEN
		SET enrlTypeId = "NONE";
    END IF;
	
    RETURN enrlTypeId;
END