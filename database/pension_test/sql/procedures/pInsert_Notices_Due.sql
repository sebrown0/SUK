CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_notices_due`(
	IN empPenId VARCHAR(40),
    IN empId VARCHAR(20))
BEGIN
	DECLARE noticeTypeId TINYINT(4);
    DECLARE noticeDueBy DATE;
    DECLARE noticeSentOn DATE;
    
	SELECT notice_type_id, (SELECT str_to_date(notice_due_by,"%d/%m/%Y")), (SELECT str_to_date(notice_sent_on,"%d/%m/%Y") )
    INTO noticeTypeId, noticeDueBy, noticeSentOn
    FROM temp_test_data;
    
    TRUNCATE notices_due;
    IF noticeTypeId IS NOT NULL THEN
		INSERT INTO notices_due
			(`notice_type_id`, `notice_due_by`, `notice_sent_on`, `employee_pension_id`, `employee_id`) 
		VALUES 
			(noticeTypeId, noticeDueBy, noticeSentOn, empPenId, empId);
	END IF;
END