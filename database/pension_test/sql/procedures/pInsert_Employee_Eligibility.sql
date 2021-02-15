CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_employee_eligibility`(
	IN empPenId VARCHAR(40))
BEGIN
	DECLARE eligibilityCode VARCHAR(5);
    DECLARE dateAchieved DATE;
    
	SELECT 
		eligibility_code, (SELECT str_to_date(eligibility_date_achieved,"%d/%m/%Y"))
    INTO 
		eligibilityCode, dateAchieved
    FROM 
		temp_test_data;
    
    TRUNCATE `salaroo_uk_pension_test`.`employee_eligibility`;
    IF eligibilityCode IS NOT NULL THEN
		INSERT INTO 
			`salaroo_uk_pension_test`.`employee_eligibility` 
            (`employee_pension_id`, `date_acheived`, `eligibility_code`) 
		VALUES 
			(empPenId, dateAchieved, eligibilityCode);
	END IF;
END