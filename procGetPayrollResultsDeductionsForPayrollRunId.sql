CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_results_deductions_for_payroll_run_id`(
	IN payRunId INT)
BEGIN
	SET @payrollRunId = payRunId;
	CALL get_all_emp_deductions_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_results_for_payroll_run_id(payRunId, FALSE);
    SELECT * FROM results_and_deductions_for_payroll_run_id;
END