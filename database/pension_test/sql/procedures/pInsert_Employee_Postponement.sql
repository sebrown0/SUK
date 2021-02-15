CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_employee_postponement`(
	IN empPenId VARCHAR(40))
BEGIN
    DECLARE postponementAllowed TINYINT;
    DECLARE isPostponed TINYINT;
    DECLARE hasBeenPostponed TINYINT;
    DECLARE dateOfPostponement DATE;
    DECLARE deferralDate DATE;

	SELECT 
		postponement_allowed,
        is_postponed,
        has_been_postponed,
        (SELECT str_to_date(date_of_postponement,"%d/%m/%Y")),
        (SELECT str_to_date(deferral_date,"%d/%m/%Y"))
    INTO 
		postponementAllowed, isPostponed, hasBeenPostponed, dateOfPostponement, deferralDate
    FROM 
		temp_test_data;
    
    TRUNCATE `salaroo_uk_pension_test`.`employee_postponement`;
    IF dateOfPostponement IS NOT NULL THEN
		INSERT INTO 
			`salaroo_uk_pension_test`.`employee_postponement` 
            (`emp_pension_id`, `postponement_allowed`, `is_postponed`, `has_been_postponed`, `date_of_postponement`, `deferral_date`) 
		VALUES 
			(empPenId, postponementAllowed, isPostponed, hasBeenPostponed, dateOfPostponement, deferralDate);
	END IF;
END