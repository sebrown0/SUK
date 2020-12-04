CREATE DEFINER=`root`@`localhost` PROCEDURE `get_payroll_run_data_for_payroll_run_id`(
	IN payRunId INT)
BEGIN
	SET @payrollRunId = payRunId;
	CALL get_all_emp_gross_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_aeos_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_s_loans_for_payroll_run_id(payRunId, FALSE);
	CALL get_all_emp_basic_for_payroll_run_id(payRunId, FALSE);    
    SELECT * FROM payroll_data_for_payroll_run_id;
END