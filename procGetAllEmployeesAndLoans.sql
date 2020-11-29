CREATE PROCEDURE `get_all_employees_and_loans` ()
BEGIN
	SELECT 		
        e.id as emp_id, e.first_name, e.last_name, 
        sl.id AS loan_id, sl.student_loan_deduction_id, 
        sl.start_date, sl.original_amount, sl.loan_type, sl.current_amount, sl.reason_for_deduction, sl.stop_notice_received
	FROM 
		employee e
		INNER JOIN 
			employee_hr hr
		ON
			e.id = hr.employee_id     
		LEFT JOIN 
			student_loan sl
		ON
			e.id = sl.employee_id
	ORDER BY sl.employee_id;
END