CREATE DEFINER=`root`@`localhost` PROCEDURE `get_included_emps_for_payroll`(
	IN payrollRunId INT)
BEGIN
	SELECT 
		employee_payroll_id 
    FROM 
		payroll_data 
	WHERE 
		payroll_run_id = payrollRunId;
END