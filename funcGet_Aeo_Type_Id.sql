CREATE DEFINER=`root`@`localhost` FUNCTION `get_aeo_type_id`(
	aeoDescription VARCHAR(45)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE typeId INT;
    
    SELECT 
		id
	INTO
		typeId
	FROM 
		aeo_type
	WHERE
		`description` = aeoDescription;

	RETURN typeId;
END