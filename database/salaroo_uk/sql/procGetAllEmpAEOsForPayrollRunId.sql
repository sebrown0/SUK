CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_emp_aeos_for_payroll_run_id`(
	IN payrollRun INT,
    IN returnRs BOOLEAN)
BEGIN
	DROP TABLE IF EXISTS all_emp_aeos_for_payroll_run_id;
    CREATE TABLE all_emp_aeos_for_payroll_run_id 
	SELECT 
		pd.payroll_run_id, pd.employee_payroll_id,
		e_aeo.*
	FROM 
		payroll_data pd
	INNER JOIN
		payroll_aeo p_aeo
	ON
		p_aeo.payroll_data_id = pd.id
	INNER JOIN 
		employee_aeo e_aeo
	ON
		p_aeo.employee_aeo_id = e_aeo.id    
	WHERE
		pd.payroll_run_id = payrollRun
	ORDER BY
		e_aeo.employee_id, e_aeo.priority; 
        
	IF returnRs = TRUE THEN
		SELECT * FROM all_emp_aeos_for_payroll_run_id;
	END IF;
END