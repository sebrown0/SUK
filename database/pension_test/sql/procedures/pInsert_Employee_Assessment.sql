CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_employee_assessment`(
	IN empPenId VARCHAR(40))
BEGIN
	DECLARE assessmentReason VARCHAR(40);	
	DECLARE assessmentDate DATE;
    DECLARE assessmentResultId INT;
    DECLARE employeeEligibilityId INT;
    DECLARE employeeEnrolmentId INT;
    DECLARE employeePostponementId INT;
    DECLARE noticesDueId INT;
	
	SELECT 	assessment_reason, (SELECT str_to_date(assessment_date,"%d/%m/%Y")), assessment_result_id
    INTO assessmentReason, assessmentDate, assessmentResultId
    FROM temp_test_data;
    
    SELECT id INTO employeeEligibilityId FROM salaroo_uk_pension_test.employee_eligibility LIMIT 1;
    IF employeeEligibilityId IS NULL THEN SET employeeEligibilityId = -1; END IF;
    
    SELECT id INTO employeeEnrolmentId FROM salaroo_uk_pension_test.employee_enroled LIMIT 1;
    IF employeeEnrolmentId IS NULL THEN SET employeeEnrolmentId = -1; END IF;
    
    SELECT id INTO employeePostponementId FROM salaroo_uk_pension_test.employee_postponement LIMIT 1;
    IF employeePostponementId IS NULL THEN SET employeePostponementId = -1; END IF;
    
    SELECT id INTO noticesDueId FROM salaroo_uk_pension_test.notices_due LIMIT 1;
    IF noticesDueId IS NULL THEN SET noticesDueId = -1; END IF;

	TRUNCATE `salaroo_uk_pension_test`.`employee_assessment`;
	INSERT INTO 
		`salaroo_uk_pension_test`.`employee_assessment` 
        (`emp_pension_id`, `assessment_date`, `assessment_reason`, `assessment_result_id`, 
        `employee_eligibility_id`, `employee_postponement_id`, `notices_due_id`, `employee_enroled_id`) 
	VALUES 
		(empPenId, assessmentDate, assessmentReason, assessmentResultId,
        employeeEligibilityId, employeePostponementId, noticesDueId, employeeEnrolmentId);
END