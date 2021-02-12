CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_emp_gross_for_payroll_run_id`(
	IN payrollRun INT,
    IN returnRs BOOLEAN)
BEGIN
	DROP TABLE IF EXISTS all_emp_gross_for_payroll_run_id;
    CREATE TABLE all_emp_gross_for_payroll_run_id
	SELECT 
		pd.payroll_run_id, pd.employee_payroll_id,
		p_gross.*
	FROM 
		payroll_data pd
	INNER JOIN
		payroll_gross p_gross
	ON
		p_gross.payroll_data_id = pd.id	
	WHERE
		pd.payroll_run_id = payrollRun; 
        
	IF returnRs = TRUE THEN
		SELECT * FROM all_emp_gross_for_payroll_run_id;
	END IF;
END