CREATE PROCEDURE `get_all_loans_for_emp` (IN emp_id VARCHAR(20))
BEGIN
	SELECT 
		* 
	FROM 
		salaroo_uk.student_loan 
    WHERE 
		employee_id = emp_id 
	ORDER BY 
		loan_type 
	ASC;
END