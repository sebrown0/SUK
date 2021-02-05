CREATE DEFINER=`root`@`localhost` PROCEDURE `create_included_emps_for_payroll`(
	IN payrollRunId INT)
BEGIN
	DROP TABLE IF EXISTS temp_included_emps;
    CREATE TEMPORARY TABLE temp_included_emps
	SELECT 
		employee_payroll_id 
    FROM 
		payroll_data 
	WHERE 
		payroll_run_id = payrollRunId;
END