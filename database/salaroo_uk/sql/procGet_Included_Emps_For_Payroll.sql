CREATE DEFINER=`root`@`localhost` PROCEDURE `get_included_emps_for_payroll`(
	IN payrollRunId INT)
BEGIN
	CALL create_included_emps_for_payroll(payrollRunId);
	SELECT * FROM temp_included_emps;
END