CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_emp_s_loans_for_payroll_run_id`(
	IN payrollRun INT,
    IN returnRs BOOLEAN)
BEGIN
	DROP TABLE IF EXISTS all_emp_s_loans_for_payroll_run_id;
    CREATE TABLE all_emp_s_loans_for_payroll_run_id
	SELECT 
		pd.payroll_run_id, pd.employee_payroll_id,
		sl.*
	FROM 
		payroll_data pd
	INNER JOIN
		payroll_student_loan p_sl
	ON
		p_sl.payroll_data_id = pd.id
	INNER JOIN 
		student_loan sl
	ON
		p_sl.student_loan_id = sl.id    
	WHERE
		pd.payroll_run_id = payrollRun
	ORDER BY
		sl.employee_id, sl.loan_type; 
        
	IF returnRs = TRUE THEN
		SELECT * FROM all_emp_s_loans_for_payroll_run_id;
	END IF;
END