CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_employee_enroled`(
	IN empPenId VARCHAR(40),
    IN empId VARCHAR(20))
BEGIN
    DECLARE isEnroled TINYINT;
    DECLARE enrolmentTypeId VARCHAR(40);
    DECLARE enrolmentDate DATE;
    
	SELECT 
		is_enroled,
        enrolment_type_id,
        (SELECT str_to_date(enrolment_date,"%d/%m/%Y"))
    INTO 
		isEnroled, enrolmentTypeId, enrolmentDate
    FROM 
		temp_test_data;
    
    TRUNCATE `salaroo_uk_pension_test`.`employee_enroled`;
    IF enrolmentTypeId IS NOT NULL THEN		
		INSERT INTO 
			`salaroo_uk_pension_test`.`employee_enroled` 
            (`employee_pension_id`, `employee_id`, `is_enroled`, `enrolment_date`, `enrolment_type_id`) 
		VALUES 
			(empPenId, empId, isEnroled, enrolmentDate, enrolmentTypeId);
	END IF;
END