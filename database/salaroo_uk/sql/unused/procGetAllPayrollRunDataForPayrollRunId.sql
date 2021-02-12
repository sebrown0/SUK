CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_payroll_run_data_for_payroll_run_id`(
	IN payRunId INT)
BEGIN
	CALL get_payroll_results_deductions_for_payroll_run_id(payRunId, FALSE);
    CALL get_payroll_run_data_for_payroll_run_id(payRunId, FALSE);
    
    SELECT 
		* 
	FROM 
		payroll_run_data_for_payroll_run_id pay_data
	LEFT JOIN 
		payroll_results_and_deductions res_ded
		ON pay_data.employee_payroll_id = res_ded.result_payroll_id;
END