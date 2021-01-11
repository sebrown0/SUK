CREATE DEFINER=`root`@`localhost` FUNCTION `get_agency_id`(
	agencyName VARCHAR(45)) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE agencyId INT;
    
    SELECT 
		id
	INTO
		agencyId
	FROM 
		aeo_agency
	WHERE
		`agency_name` = agencyName;

	RETURN agencyId;
END