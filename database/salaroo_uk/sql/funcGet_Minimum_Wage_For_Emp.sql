CREATE DEFINER=`root`@`localhost` FUNCTION `get_minimum_wage_for_emp`(
	empCode VARCHAR(45), 
    taxYr VARCHAR(4)) RETURNS decimal(4,2)
    DETERMINISTIC
BEGIN
	DECLARE mwv DECIMAL(4,2) DEFAULT 0;
    DECLARE empAge INT;
    DECLARE isApprentice TINYINT;
    DECLARE getsApprenticeRate TINYINT;
    
    SELECT get_employees_age(empCode) INTO empAge; 
    SELECT is_apprentice INTO isApprentice FROM employment_type WHERE employee_id = empCode;
    
    -- ---------------------------------------------------------------
    -- An employee gets the apprentice rate if they are an
    -- apprentice and they are in the first year of an apprenticeship.
    --
    -- We don't have a way to check if it's their first year
    -- so all apprentices get the apprentice rate.
    -- ---------------------------------------------------------------
    SET getsApprenticeRate = isApprentice;
    
    IF getsApprenticeRate THEN
		SELECT apprentice 
        INTO mwv FROM  minimum_wage 
        WHERE tax_year_id = taxYr;
    ELSEIF empAge > 25 THEN
		SELECT national_living_wage 
        INTO mwv FROM  minimum_wage 
        WHERE tax_year_id = taxYr;
    ELSEIF empAge >= 21 AND empAge <= 24 THEN
		SELECT `21_24_yr_old` 
        INTO mwv FROM  minimum_wage 
        WHERE tax_year_id = taxYr;
	ELSEIF empAge >= 18 AND empAge <= 20 THEN
		SELECT `18_20_yr_old` 
        INTO mwv FROM  minimum_wage 
        WHERE tax_year_id = taxYr;
	ELSEIF empAge >= 16 AND empAge <= 17 THEN
		SELECT `16_17_yr_old` 
        INTO mwv FROM  minimum_wage 
        WHERE tax_year_id = taxYr;
	ELSEIF empAge >= 16 AND empAge <= 17 THEN
		SELECT `16_17_yr_old` 
        INTO mwv FROM  minimum_wage 
        WHERE tax_year_id = taxYr;
    END IF;
	
    RETURN mwv;
END