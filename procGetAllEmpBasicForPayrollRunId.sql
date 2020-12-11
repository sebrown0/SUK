CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_emp_basic_for_payroll_run_id`(
	IN payrollRun INT,
    IN returnRs BOOLEAN)
BEGIN
	DROP TABLE IF EXISTS all_emp_basic_for_payroll_run_id;
    CREATE TABLE all_emp_basic_for_payroll_run_id
	SELECT 
		pd.payroll_run_id, pd.employee_payroll_id,
		p_basic.*
	FROM 
		payroll_data pd
	INNER JOIN
		payroll_basic p_basic
	ON
		p_basic.payroll_data_id = pd.id	
	WHERE
		pd.payroll_run_id = payrollRun; 
        
	IF returnRs = TRUE THEN
		SELECT * FROM get_all_emp_basic_for_payroll_run_id;
	END IF;
END