CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_emp_results_for_payroll_run_id`(
	IN payrollRun INT,
    IN returnRs BOOLEAN)
BEGIN
	DROP TABLE IF EXISTS all_emp_results_for_payroll_run_id;
	CREATE TABLE all_emp_results_for_payroll_run_id 
	SELECT 
		epr.payroll_run_id ,epr.employee_payroll_details_payroll_id,
		epr.gross_pay, epr.basic_pay , epr.net_pay, epr.bonus 
	FROM
		payroll_result_payment epr
	WHERE
		epr.payroll_run_id = payrollRun; 
        
	IF returnRs = TRUE THEN
		SELECT * FROM all_emp_results_for_payroll_run_id;
	END IF;
END