CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_assessment_result`(
	IN empPenId VARCHAR(40))
BEGIN
	DECLARE assessmentReason VARCHAR(40);	
	DECLARE assessmentDate DATE;
    DECLARE employeeEligibilityId INT;
    DECLARE employeePostponementId INT;
    DECLARE noticesDueId INT;
	
	SELECT 	assessment_reason, (SELECT str_to_date(assessment_date,"%d/%m/%Y"))
    INTO assessmentReason, assessmentDate
    FROM temp_test_data;
    
    SELECT id INTO employeeEligibilityId FROM salaroo_uk_pension_test.employee_eligibility LIMIT 1;
    IF employeeEligibilityId IS NULL THEN SET employeeEligibilityId = -1; END IF;
    
    SELECT id INTO employeePostponementId FROM salaroo_uk_pension_test.employee_postponement LIMIT 1;
    IF employeePostponementId IS NULL THEN SET employeePostponementId = -1; END IF;
    
    SELECT id INTO noticesDueId FROM salaroo_uk_pension_test.notices_due LIMIT 1;
    IF noticesDueId IS NULL THEN SET noticesDueId = -1; END IF;
    
	TRUNCATE `salaroo_uk_pension_test`.`assessment_result`;
	INSERT INTO 
		`salaroo_uk_pension_test`.`assessment_result` 
        (`emp_pension_id`, `assessment_date`, `assessment_reason`, `employee_eligibility_id`, `employee_postponement_id`, `notices_due_id`) 
	VALUES 
		(empPenId, assessmentDate, assessmentReason, 
        employeeEligibilityId, employeePostponementId, noticesDueId);
END