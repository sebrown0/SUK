CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_payroll_run_data_for_payroll_run_id`(
	IN payRunId INT)
BEGIN
	SET @payrollRunId = payRunId;
    
	CALL get_all_emp_gross_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_aeos_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_s_loans_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_basic_for_payroll_run_id(payRunId, FALSE);   
    CALL get_all_emp_deductions_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_results_for_payroll_run_id(payRunId, FALSE);
    
    SELECT 
		* 
	FROM 
		payroll_data_for_payroll_run_id prd
	LEFT JOIN 
		results_and_deductions_for_payroll_run_id res
		ON res.result_payroll_id = prd.employee_payroll_id;
END