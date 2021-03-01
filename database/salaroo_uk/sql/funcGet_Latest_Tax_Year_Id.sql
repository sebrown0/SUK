CREATE DEFINER=`root`@`localhost` FUNCTION `get_latest_tax_year_id`(employerId VARCHAR(40)) RETURNS varchar(4) CHARSET utf8
    DETERMINISTIC
BEGIN
	DECLARE taxYrId VARCHAR(4);
    
    SELECT MAX(id) INTO taxYrId 
    FROM tax_year
    WHERE employer_id = employerId
	GROUP BY employer_id;

	RETURN taxYrId;
END