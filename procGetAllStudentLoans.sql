CREATE PROCEDURE `get_all_student_loans` ()
BEGIN
	SELECT * FROM salaroo_uk.student_loan ORDER BY employee_id;
END